//
//  OptionSetRepresentationMacro.swift
//  VCoreMacrosImplementation
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

#if !(os(iOS) || os(tvOS) || os(watchOS) || os(visionOS))

import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics

nonisolated struct OptionSetRepresentationMacro: MemberMacro, ExtensionMacro {
    // MARK: Member Macro
    static func expansion(
        of attribute: AttributeSyntax,
        providingMembersOf decl: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        // Macro expansion data
        let expansionData: ExpansionData
        do {
            expansionData = try decodeExpansion(
                attribute: attribute,
                declaration: decl,
                context: context
            )
        } catch {
            return []
        }

        // `Option` `enum` cases
        let optionEnumCases: [EnumCaseElementSyntax] = expansionData
            .optionsEnumDeclaration
            .memberBlock
            .members
            .compactMap { $0.decl.as(EnumCaseDeclSyntax.self) }
            .flatMap { $0.elements } // Retrieves all cases from the same line

        // Macro expansion result
        return memberResult(
            expansionData: expansionData,
            optionEnumCases: optionEnumCases
        )
    }

    private static func memberResult(
        expansionData: ExpansionData,
        optionEnumCases: [EnumCaseElementSyntax]
    ) -> [DeclSyntax] {
        var result: [DeclSyntax] = []
        
        let prefix: String = "\(expansionData.accessLevelModifier) "

        result.append("\(raw: prefix)typealias RawValue = \(expansionData.rawType)")

        result.append("\(raw: prefix)let rawValue: RawValue")

        result.append(
            """
            \(raw: prefix)init() {
                self.rawValue = 0
            }
            """
        )

        result.append(
            """
            \(raw: prefix)init(rawValue: RawValue) {
                self.rawValue = rawValue
            }
            """
        )

        for optionEnumCase in optionEnumCases {
            result.append(
                """
                \(raw: prefix)static let \(optionEnumCase.name): Self = .init(rawValue: 1 << \(raw: expansionData.optionsEnumDeclaration.name).\(optionEnumCase.name).rawValue)
                """
            )
        }

        do {
            var string: String = ""

            string.append("\(prefix)static let all: Self = [")
            string.append("\n")

            for (i, optionEnumCase) in optionEnumCases.enumerated() {
                string.append(".\(optionEnumCase.name)")
                if i != optionEnumCases.count-1 { string.append(",") }

                string.append("\n")
            }

            string.append("]")
            string.append("\n")

            result.append("\(raw: string)")
        }

        return result
    }

    // MARK: Extension Macro
    static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [ExtensionDeclSyntax] {
        // Macro expansion data
        let expansionData: ExpansionData
        do {
            expansionData = try decodeExpansion(
                attribute: node,
                declaration: declaration,
                context: context,
                diagnose: false // Diagnostics occur within `MemberMacro`
            )
        } catch {
            return []
        }

        // Macro expansion result
        return try extensionResult(
            type: type,
            expansionData: expansionData,
            context: context,
            diagnose: false // Diagnostics occur within `MemberMacro`
        )
    }

    private static func extensionResult(
        type: some TypeSyntaxProtocol,
        expansionData: ExpansionData,
        context: some MacroExpansionContext,
        diagnose: Bool
    ) throws -> [ExtensionDeclSyntax] {
        // Skips conformance, if it already exits
        if
            let inheritedTypes: InheritedTypeListSyntax = expansionData
                .structDeclaration
                .inheritanceClause?
                .inheritedTypes,
            inheritedTypes.contains(where: { inheritedType in
                inheritedType.trimmedDescription == "OptionSet"
            })
        {
            return []

        } else {
            let prefix: String = "\(expansionData.isNonIsolated ? " nonisolated " : "")"
            
            var result: [DeclSyntax] = []

            result.append("\(raw: prefix)extension \(raw: type): OptionSet {}") // Works, even if type is nested

            return try result
                .map { member in
                    guard let result: ExtensionDeclSyntax = member.as(ExtensionDeclSyntax.self) else {
                        let error: RawStringError = .init("Failed to generate macro expansion")
                        if diagnose { context.addDiagnostics(from: error, node: type) }
                        throw error
                    }
                    
                    return result
                }
        }
    }

    // MARK: Parameters
    private static func decodeExpansion(
        attribute: AttributeSyntax,
        declaration: some DeclGroupSyntax,
        context: some MacroExpansionContext,
        diagnose: Bool = true
    ) throws -> ExpansionData {
        // Macro Parameters
        let accessLevelModifier: AccessLevelModifierKeyword = try accessLevelModifierParameter(
            attribute: attribute,
            declaration: declaration,
            context: context,
            diagnose: diagnose
        )
        
        let isNonIsolated: Bool = isNonIsolated(
            declaration: declaration
        )

        // Limits declaration to `struct`s
        guard
            let structDeclaration: StructDeclSyntax = declaration.as(StructDeclSyntax.self)
        else {
            let error: RawStringError = .init("'OptionSetRepresentation' macro can only be applied to 'struct's")
            if diagnose { context.addDiagnostics(from: error, node: declaration) }
            throw error
        }

        // `Option` `enum` within the `struct`
        guard
            let optionsEnumDeclaration: EnumDeclSyntax = declaration.memberBlock.members
                .first(where: { member in
                    guard
                        let enumDeclaration: EnumDeclSyntax = member.decl.as(EnumDeclSyntax.self),
                        enumDeclaration.name.trimmedDescription == "Options"
                    else {
                        return false
                    }
                    
                    return true
                })?
                .decl.as(EnumDeclSyntax.self)
        else {
            let error: RawStringError = .init("Options 'enum' listing all the options not found")
            if diagnose { context.addDiagnostics(from: error, node: declaration) }
            throw error
        }

        // Raw type from `Option` `enum`
        guard
            let genericArgument: GenericArgumentClauseSyntax = attribute
                .attributeName.as(IdentifierTypeSyntax.self)?
                .genericArgumentClause,
            let rawType: GenericArgumentSyntax.Argument = genericArgument.arguments.first?.argument // Only one raw type
        else {
            let error: RawStringError = .init("Options 'enum' doesn't have a raw type")
            if diagnose { context.addDiagnostics(from: error, node: optionsEnumDeclaration) }
            throw error
        }

        // Macro expansion result
        return ExpansionData(
            accessLevelModifier: accessLevelModifier,
            isNonIsolated: isNonIsolated,
            structDeclaration: structDeclaration,
            optionsEnumDeclaration: optionsEnumDeclaration,
            rawType: rawType
        )
    }

    // MARK: Macro Parameters
    private static func accessLevelModifierParameter(
        attribute: AttributeSyntax,
        declaration: some DeclGroupSyntax,
        context: some MacroExpansionContext,
        diagnose: Bool
    ) throws -> AccessLevelModifierKeyword {
        guard
            let parameter: LabeledExprSyntax = attribute
                .arguments?
                .toArgumentListGetAssociatedValue()?
                .first(where: { $0.label?.trimmedDescription == "accessLevelModifier" }),
            !parameter.expression.is(NilLiteralExprSyntax.self)
        else {
            let inheritedValue: AccessLevelModifierKeyword? = .allCases.first { aCase in
                declaration.modifiers.contains { modifier in
                    modifier.name.tokenKind.toKeywordAssociatedValue() == aCase.swiftSyntaxKeyword
                }
            }

            return inheritedValue ?? AccessLevelModifierKeyword.default
        }

        guard
            let valueString: String = parameter
                .expression.as(MemberAccessExprSyntax.self)?
                .declName
                .baseName
                .trimmedDescription,

            let value: AccessLevelModifierKeyword = .init(rawValue: valueString)
        else {
            let error: RawStringError = .init("Invalid 'accessLevelModifier' parameter")
            if diagnose { context.addDiagnostics(from: error, node: parameter) }
            throw error
        }

        return value
    }
    
    private static func isNonIsolated(
        declaration: some DeclGroupSyntax
    ) -> Bool {
        declaration.modifiers.contains { $0.name.tokenKind == .keyword(.nonisolated) }
    }
    
    // MARK: Types
    private nonisolated struct ExpansionData {
        let accessLevelModifier: AccessLevelModifierKeyword
        let isNonIsolated: Bool
        let structDeclaration: StructDeclSyntax
        let optionsEnumDeclaration: EnumDeclSyntax
        let rawType: GenericArgumentSyntax.Argument
    }
}

#endif
