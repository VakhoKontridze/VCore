//
//  OptionSetRepresentationMacro.swift
//  VCoreMacros
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
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        // Expansion data
        let expansionData: ExpansionData = try decodeExpansion(
            attribute: attribute,
            declaration: decl,
            context: context
        )

        // `Option` `enum` cases
        let optionEnumCases: [EnumCaseElementSyntax] = expansionData
            .optionsEnumDeclaration
            .memberBlock
            .members
            .compactMap { $0.decl.as(EnumCaseDeclSyntax.self) }
            .flatMap { $0.elements } // Retrieves all cases from the same line

        // Result
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
        // Expansion data
        guard
            let expansionData: ExpansionData = try? decodeExpansion(
                attribute: node,
                declaration: declaration,
                context: context
            )
        else {
            return [] // Errors are thrown from `MemberMacro`
        }

        // Result
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
            inheritedTypes.contains(where: { $0.trimmedDescription == "OptionSet" })
        {
            return []

        } else {
            var result: [DeclSyntax] = []

            result.append( // Works, even if type is nested
                """
                extension \(raw: type): OptionSet {}
                """
            )

            return result.compactMap { $0.as(ExtensionDeclSyntax.self) }
        }
    }

    // MARK: Expansion Data
    private struct ExpansionData {
        let accessLevelModifier: AccessLevelModifierKeyword
        let structDeclaration: StructDeclSyntax
        let optionsEnumDeclaration: EnumDeclSyntax
        let rawType: TypeSyntax
    }

    private static func decodeExpansion(
        attribute: AttributeSyntax,
        declaration: some DeclGroupSyntax,
        context: some MacroExpansionContext
    ) throws -> ExpansionData {
        // Parameters
        let accessLevelModifier: AccessLevelModifierKeyword = try accessLevelModifierParameter(attribute: attribute)

        // Limits declaration to `struct`s
        guard
            let structDeclaration: StructDeclSyntax = declaration.as(StructDeclSyntax.self)
        else {
            throw OptionSetRepresentationMacroError.canOnlyBeAppliedToStructs
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
            throw OptionSetRepresentationMacroError.optionsEnumNotFound
        }

        // Raw type from `Option` `enum`
        guard
            let geneticArgument: GenericArgumentClauseSyntax = attribute
                .attributeName.as(IdentifierTypeSyntax.self)?
                .genericArgumentClause,
            let rawType: TypeSyntax = geneticArgument.arguments.first?.argument // Only one raw type
        else {
            throw OptionSetRepresentationMacroError.optionsEnumRawTypeNotDeclared
        }

        // Result
        return ExpansionData(
            accessLevelModifier: accessLevelModifier,
            structDeclaration: structDeclaration,
            optionsEnumDeclaration: optionsEnumDeclaration,
            rawType: rawType
        )
    }

    private static func accessLevelModifierParameter(
        attribute: AttributeSyntax
    ) throws -> AccessLevelModifierKeyword {
        guard
            let parameter: LabeledExprSyntax = attribute
                .arguments?
                .toArgumentListGetAssociatedValue()?
                .first(where: { $0.label?.trimmedDescription == "accessLevelModifier" })
        else {
            return AccessLevelModifierKeyword.internal // Default value
        }

        guard
            let valueString: String = parameter
                .expression.as(MemberAccessExprSyntax.self)?
                .declName
                .baseName
                .trimmedDescription,

            let value: AccessLevelModifierKeyword = .init(rawValue: valueString)
        else {
            throw OptionSetRepresentationMacroError.invalidAccessLevelModifierParameter
        }

        return value
    }
}
