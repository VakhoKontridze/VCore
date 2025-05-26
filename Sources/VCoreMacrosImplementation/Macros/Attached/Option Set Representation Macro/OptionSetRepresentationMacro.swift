//
//  OptionSetRepresentationMacro.swift
//  VCoreMacrosImplementation
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics

// MARK: - Option Set Representation Macro
struct OptionSetRepresentationMacro: MemberMacro, ExtensionMacro {
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

        result.append("\(raw: expansionData.accessLevelModifier) typealias RawValue = \(expansionData.rawType)")

        result.append("\(raw: expansionData.accessLevelModifier) let rawValue: RawValue")

        result.append(
            """
            \(raw: expansionData.accessLevelModifier) init() {
                self.rawValue = 0
            }
            """
        )

        result.append(
            """
            \(raw: expansionData.accessLevelModifier) init(rawValue: RawValue) {
                self.rawValue = rawValue
            }
            """
        )

        for optionEnumCase in optionEnumCases {
            result.append(
                """
                \(raw: expansionData.accessLevelModifier) static let \(optionEnumCase.name): Self = .init(rawValue: 1 << \(raw: expansionData.optionsEnumDeclaration.name).\(optionEnumCase.name).rawValue)
                """
            )
        }

        do {
            var string: String = ""

            string.append("\(expansionData.accessLevelModifier) static let all: Self = [")
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
        return extensionResult(
            type: type,
            expansionData: expansionData
        )
    }

    private static func extensionResult(
        type: some TypeSyntaxProtocol,
        expansionData: ExpansionData
    ) -> [ExtensionDeclSyntax] {
        // Skips conformance, if it already exits
        if
            let inheritedTypes: InheritedTypeListSyntax = expansionData
                .structDeclaration
                .inheritanceClause?
                .inheritedTypes,
            inheritedTypes.contains(where: { inheritedType in
                inheritedType
                    .trimmedDescription
                    .replacingOccurrences(of: ",", with: "")
                == "OptionSet"
            })
        {
            return []

        } else {
            var result: [DeclSyntax] = []

            result.append("extension \(raw: type): OptionSet {}") // Works, even if type is nested

            return result.compactMap { $0.as(ExtensionDeclSyntax.self) }
        }
    }

    // MARK: Expansion Data
    private struct ExpansionData {
        let accessLevelModifier: AccessLevelModifierKeyword
        let structDeclaration: StructDeclSyntax
        let optionsEnumDeclaration: EnumDeclSyntax
        let rawType: GenericArgumentSyntax.Argument
    }

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
            let geneticArgument: GenericArgumentClauseSyntax = attribute
                .attributeName.as(IdentifierTypeSyntax.self)?
                .genericArgumentClause,
            let rawType: GenericArgumentSyntax.Argument = geneticArgument.arguments.first?.argument // Only one raw type
        else {
            let error: RawStringError = .init("Options 'enum' doesn't have a raw type")
            if diagnose { context.addDiagnostics(from: error, node: optionsEnumDeclaration) }
            throw error
        }

        // Macro expansion result
        return ExpansionData(
            accessLevelModifier: accessLevelModifier,
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
            let inheritedValue: AccessLevelModifierKeyword? = .allCases.first(where: { aCase in
                declaration.modifiers.contains(where: { modifier in
                    modifier.name.tokenKind.toKeywordAssociatedValue() == aCase.swiftSyntaxKeyword
                })
            })

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
}
