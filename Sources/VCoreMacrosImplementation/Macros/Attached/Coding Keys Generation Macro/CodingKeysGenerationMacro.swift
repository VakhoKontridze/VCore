//
//  CodingKeysGenerationMacro.swift
//  VCoreMacrosImplementation
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

import Foundation
import SwiftSyntax
import SwiftSyntaxMacros
import VCoreShared

// MARK: - Coding Keys Generation Macro
struct CodingKeysGenerationMacro: MemberMacro {
    // MARK: Member Macro
    static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        // Parameters
        let accessLevelModifier: AccessLevelModifierKeyword = try accessLevelModifierParameter(attribute: node)

        // Properties
        let properties: [PropertyData] = try declaration
            .memberBlock
            .members
            .compactMap { try property(member: $0) }

        // Result
        return result(
            accessLevelModifier: accessLevelModifier,
            properties: properties
        )
    }

    // MARK: Parameters
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
            throw CodingKeysGenerationMacroError.invalidAccessLevelModifierParameter
        }

        return value
    }

    // MARK: Data
    private struct PropertyData {
        let name: String
        let key: String?
    }

    private static func property(
        member: MemberBlockItemSyntax
    ) throws -> PropertyData? {
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
            member
                .decl.as(VariableDeclSyntax.self)?
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

        // Property key
        let propertyKey: String? = try {
            guard
                let keyMacro: AttributeSyntax = member
                    .decl.as(VariableDeclSyntax.self)?
                    .attributes
                    .first(where: { attribute in
                        attribute.as(AttributeSyntax.self)?
                            .attributeName.as(IdentifierTypeSyntax.self)?
                            .description == "CKGCodingKey"
                    })?.as(AttributeSyntax.self)
            else {
                return nil
            }

            guard
                let propertyKey: String = keyMacro
                    .arguments?.as(LabeledExprListSyntax.self)?
                    .first? // Only one argument, with no name
                    .expression.as(StringLiteralExprSyntax.self)?
                    .segments
                    .first?.as(StringSegmentSyntax.self)?
                    .content
                    .trimmedDescription
            else {
                throw CodingKeysGenerationMacroError.invalidKeyName
            }

            return propertyKey
        }()

        // Result
        return PropertyData(
            name: propertyName,
            key: propertyKey
        )
    }

    // MARK: Result
    private static func result(
        accessLevelModifier: AccessLevelModifierKeyword,
        properties: [PropertyData]
    ) -> [DeclSyntax] {
        // Result
        var result: [DeclSyntax] = []

        loop: do {
            guard !properties.isEmpty else { break loop }

            var string: String = ""

            string.append("\(accessLevelModifier) enum CodingKeys: String, CodingKey {")
            string.append("\n")

            for property in properties {
                if let key: String = property.key {
                    string.append("case \(property.name) = \"\(key)\"")
                } else {
                    string.append("case \(property.name)")
                }

                string.append("\n")
            }

            string.append("}")
            string.append("\n")

            result.append("\(raw: string)")
        }

        return result
    }
}
