//
//  MemberwiseCodableMacro.swift
//  VCoreMacros
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

import Foundation
import SwiftSyntax
import SwiftSyntaxMacros
import VCoreShared

// MARK: - Memberwise Codable Macro
struct MemberwiseCodableMacro: MemberMacro {
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
                throw MemberwiseCodableMacroError.invalidAccessLevelModifierParameter
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
                    throw MemberwiseCodableMacroError.onePropertyAllowedPerLine
                }

                guard
                    propertyBinding.accessorBlock == nil
                else {
                    return nil // Skipping computer properties
                }

                guard
                    let propertyName: String = propertyBinding.pattern.as(IdentifierPatternSyntax.self)?.identifier.text
                else {
                    throw MemberwiseCodableMacroError.invalidPropertyName
                }

                if
                    member.decl.as(VariableDeclSyntax.self)?
                        .attributes
                        .contains(where: { attribute in
                            attribute.as(AttributeSyntax.self)?
                                .attributeName.as(IdentifierTypeSyntax.self)?
                                .description
                                ._removing(.whitespaces) == "MWCCodingKeyIgnored"
                        })
                        == true
                {
                    return nil // Ignores `MWCCodingKeyIgnored` macro
                }

                guard
                    let keyMacro: AttributeListSyntax.Element = member.decl.as(VariableDeclSyntax.self)?
                        .attributes
                        .first(where: { attribute in
                            attribute.as(AttributeSyntax.self)?
                                .attributeName.as(IdentifierTypeSyntax.self)?
                                .description == "MWCCodingKey"
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
                    throw MemberwiseCodableMacroError.invalidKeyName
                }

                return "case \(propertyName) = \(customKeyValue)"
            }

        // Result
        var result: [DeclSyntax] = []

        result.append(
            """
            \(raw: accessLevelModifier) enum CodingKeys: String, CodingKey {
                \(raw: codingKeyLines.joined(separator: "\n"))
            }
            """
        )

        return result
    }
}

// MARK: - Coding Key Macro
struct MWCCodingKeyMacro: PeerMacro {
    static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        []
    }
}

// MARK: - Coding Key Ignored Macro
struct MWCCodingKeyIgnoredMacro: PeerMacro {
    static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        []
    }
}

// MARK: - Memberwise Codable Macro Error
struct MemberwiseCodableMacroError: Error, CustomStringConvertible {
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
