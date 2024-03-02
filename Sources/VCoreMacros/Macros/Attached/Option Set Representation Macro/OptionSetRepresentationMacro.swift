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

        // `Option` enum cases
        let optionEnumCases: [EnumCaseElementSyntax] = expansionData
            .optionsEnumDeclaration
            .memberBlock
            .members
            .compactMap { $0.decl.as(EnumCaseDeclSyntax.self) }
            .flatMap { $0.elements } // Retrieves all cases from the same line

        // Result
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

        // Result.
        // Skips conformance, if it already exits.
        // This is essential, if declaration has availability attributes.
        if
            let inheritedTypes: InheritedTypeListSyntax = expansionData.structDeclaration.inheritanceClause?.inheritedTypes,
            inheritedTypes.contains(where: { $0.trimmedDescription == "OptionSet" })
        {
            return []

        } else {
            var result: [DeclSyntax] = []

            result.append(
                """
                extension \(raw: type): OptionSet {}
                """
            )

            return result.compactMap { $0.as(ExtensionDeclSyntax.self) }
        }
    }

    // MARK: Helpers
    private struct ExpansionData {
        let accessLevelModifier: String
        let structDeclaration: StructDeclSyntax
        let optionsEnumDeclaration: EnumDeclSyntax
        let rawType: TypeSyntax
    }

    // Decodes arguments and extract various roles used by both protocols.
    private static func decodeExpansion(
        attribute: AttributeSyntax,
        declaration: some DeclGroupSyntax,
        context: some MacroExpansionContext
    ) throws -> ExpansionData {
        // Parameter - accessLevelModifier
        let accessLevelModifier: String = try {
            guard
                let argument: LabeledExprSyntax? = attribute.arguments?.toArgumentListGetAssociatedValue()?
                    .first(where: { $0.label?.text == "accessLevelModifier" })
            else {
                return "internal" // Default value
            }

            guard
                let value: String = argument?.expression.as(StringLiteralExprSyntax.self)?.representedLiteralValue
            else {
                throw OptionSetRepresentationMacroError.invalidAccessLevelModifierParameter
            }

            return value
        }()

        // Limits declaration to structs
        guard
            let structDeclaration: StructDeclSyntax = declaration.as(StructDeclSyntax.self)
        else {
            throw OptionSetRepresentationMacroError.canOnlyBeAppliedToStructs
        }

        // `Option` enum within the struct
        guard
            let optionsEnumDeclaration: EnumDeclSyntax = declaration.memberBlock.members
                .first(where: { member in
                    guard
                        let enumDeclaration: EnumDeclSyntax = member.decl.as(EnumDeclSyntax.self),
                        enumDeclaration.name.text == "Options"
                    else {
                        return false
                    }

                    return true
                })?
                .decl.as(EnumDeclSyntax.self)
        else {
            throw OptionSetRepresentationMacroError.optionsEnumNotFound
        }

        // Raw type from `Option` enum
        guard
            let geneticArgument: GenericArgumentClauseSyntax = attribute.attributeName.as(IdentifierTypeSyntax.self)?
                .genericArgumentClause,
            let rawType: TypeSyntax = geneticArgument.arguments.first?.argument // Only one raw type
        else {
            throw OptionSetRepresentationMacroError.optionsEnumRawTypeNotDeclared
        }

        // Returns
        return ExpansionData(
            accessLevelModifier: accessLevelModifier,
            structDeclaration: structDeclaration,
            optionsEnumDeclaration: optionsEnumDeclaration,
            rawType: rawType
        )
    }
}
