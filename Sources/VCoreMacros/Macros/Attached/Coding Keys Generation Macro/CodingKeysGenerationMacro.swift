//
//  CodingKeysGenerationMacro.swift
//  VCoreMacros
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

import Foundation
import SwiftSyntax
import SwiftSyntaxMacros
import VCoreShared

// MARK: - Coding Keys Generation Macro
struct CodingKeysGenerationMacro: MemberMacro {
    static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        // Parameters
        let accessLevelModifier: String = try accessLevelModifierParameter(node: node)

        // Result
        return try result(
            declaration: declaration,
            accessLevelModifier: accessLevelModifier
        )
    }

    private static func accessLevelModifierParameter(
        node: AttributeSyntax
    ) throws -> String {
        guard
            let argument: LabeledExprSyntax = node
                .arguments?
                .toArgumentListGetAssociatedValue()?
                .first(where: { $0.label?.trimmedDescription == "accessLevelModifier" })
        else {
            return "internal" // Default value
        }

        guard
            let value: String = argument
                .expression.as(StringLiteralExprSyntax.self)?
                .representedLiteralValue
        else {
            throw CodingKeysGenerationMacroError.invalidAccessLevelModifierParameter
        }

        return value
    }

    private static func result(
        declaration: some DeclGroupSyntax,
        accessLevelModifier: String
    ) throws -> [DeclSyntax] {
        // `CodingKey` lines
        let codingKeyLines: [String] = try declaration
            .memberBlock
            .members
            .compactMap { try codingKeyLine(member: $0) }

        // Result
        var result: [DeclSyntax] = []

        if !codingKeyLines.isEmpty {
            result.append(
                """
                \(raw: accessLevelModifier) enum CodingKeys: String, CodingKey {
                    \(raw: codingKeyLines.joined(separator: "\n"))
                }
                """
            )
        }

        return result
    }

    private static func codingKeyLine(
        member: MemberBlockItemSyntax
    ) throws -> String? {
        // Limits declaration to variables
        guard
            let propertyDeclaration: VariableDeclSyntax = member.decl.as(VariableDeclSyntax.self)
        else {
            return nil
        }

        // Limits declaration to one property per line
        guard
            propertyDeclaration.bindings.count == 1,
            let propertyBinding: PatternBindingListSyntax.Element = propertyDeclaration.bindings.first
        else {
            throw CodingKeysGenerationMacroError.onePropertyAllowedPerLine
        }

        // Skips computed properties
        guard
            propertyBinding.accessorBlock == nil
        else {
            return nil
        }

        // Property name
        guard
            let propertyName: String = propertyBinding
                .pattern.as(IdentifierPatternSyntax.self)?
                .identifier
                .trimmedDescription
        else {
            throw CodingKeysGenerationMacroError.invalidPropertyName
        }

        // Skips `CKGCodingKeyIgnored`
        if
            member.decl.as(VariableDeclSyntax.self)?
                .attributes
                .contains(where: { attribute in
                    attribute.as(AttributeSyntax.self)?
                        .attributeName.as(IdentifierTypeSyntax.self)?
                        .description
                        ._removing(.whitespaces) == "CKGCodingKeyIgnored"
                })
                == true
        {
            return nil
        }

        // Early exit for non-`CKGCodingKey` properties
        guard
            let keyMacro: AttributeListSyntax.Element = member.decl.as(VariableDeclSyntax.self)?
                .attributes
                .first(where: { attribute in
                    attribute.as(AttributeSyntax.self)?
                        .attributeName.as(IdentifierTypeSyntax.self)?
                        .description == "CKGCodingKey"
                })
        else {
            return "case \(propertyName)"
        }

        // Value
        guard
            let customKeyValue: ExprSyntax = keyMacro.as(AttributeSyntax.self)?
                .arguments?.as(LabeledExprListSyntax.self)?
                .first? // Only one argument, with no name
                .expression
        else {
            throw CodingKeysGenerationMacroError.invalidKeyName
        }

        // Result
        return "case \(propertyName) = \(customKeyValue)"
    }
}
