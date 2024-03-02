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
        // `accessLevelModifier` parameter
        let accessLevelModifier: String = try {
            guard
                let argument: LabeledExprSyntax? = node.arguments?.toArgumentListGetAssociatedValue()?
                    .first(where: { $0.label?.text == "accessLevelModifier" })
            else {
                return "internal" // Default value
            }

            guard
                let value: String = argument?.expression.as(StringLiteralExprSyntax.self)?.representedLiteralValue
            else {
                throw CodingKeysGenerationMacroError.invalidAccessLevelModifierParameter
            }

            return value
        }()

        // Coding key lines
        let codingKeyLines: [String] = try declaration.memberBlock.members
            .compactMap { member in
                guard
                    let propertyDeclaration: VariableDeclSyntax = member.decl.as(VariableDeclSyntax.self)
                else {
                    return nil // Limits declaration to variables
                }

                guard
                    propertyDeclaration.bindings.count == 1,
                    let propertyBinding: PatternBindingListSyntax.Element = propertyDeclaration.bindings.first
                else {
                    throw CodingKeysGenerationMacroError.onePropertyAllowedPerLine
                }

                guard
                    propertyBinding.accessorBlock == nil
                else {
                    return nil // Skipping computer properties
                }

                guard
                    let propertyName: String = propertyBinding.pattern.as(IdentifierPatternSyntax.self)?.identifier.text
                else {
                    throw CodingKeysGenerationMacroError.invalidPropertyName
                }

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
                    return nil // Ignores `CKGCodingKeyIgnored` macro
                }

                guard
                    let keyMacro: AttributeListSyntax.Element = member.decl.as(VariableDeclSyntax.self)?
                        .attributes
                        .first(where: { attribute in
                            attribute.as(AttributeSyntax.self)?
                                .attributeName.as(IdentifierTypeSyntax.self)?
                                .description == "CKGCodingKey"
                        })
                else {
                    return "case \(propertyName)" // Doesn't use `MWVCodingKey` macro
                }

                guard
                    let customKeyValue: ExprSyntax = keyMacro.as(AttributeSyntax.self)?
                        .arguments?.as(LabeledExprListSyntax.self)?
                        .first? // Only one argument, with no name
                        .expression
                else {
                    throw CodingKeysGenerationMacroError.invalidKeyName
                }

                return "case \(propertyName) = \(customKeyValue)"
            }

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
}

// MARK: - Coding Key Macro
struct CKGCodingKeyMacro: PeerMacro {
    static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        []
    }
}

// MARK: - Coding Key Ignored Macro
struct CKGCodingKeyIgnoredMacro: PeerMacro {
    static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        []
    }
}

// MARK: - Coding Keys Generation Macro Error
struct CodingKeysGenerationMacroError: Error, CustomStringConvertible {
    // MARK: Properties
    let description: String

    // MARK: Initializers
    private init(
        _ description: String
    ) {
        self.description = description
    }

    static var invalidAccessLevelModifierParameter: Self { .init("Invalid 'accessLevelModifier' parameter") }
    static var onePropertyAllowedPerLine: Self { .init("Only one property declaration is allowed per line") }
    static var invalidPropertyName: Self { .init("Invalid property name") }
    static var invalidKeyName: Self { .init("Invalid key name") }
}
