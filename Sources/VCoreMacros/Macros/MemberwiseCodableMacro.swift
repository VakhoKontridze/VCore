//
//  MemberwiseCodableMacro.swift
//  VCoreMacros
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

import Foundation
import SwiftSyntax
import SwiftSyntaxMacros

// MARK: - Memberwise Codable Macro
struct MemberwiseCodableMacro: MemberMacro {
    static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        // Parameter - accessLevelModifier
        let accessLevelModifier: String

        let accessLevelModifierArgument: LabeledExprSyntax? = node.arguments?.argumentListAssociatedValue?.first

        if let accessLevelModifierArgument {
            guard
                let accessLevelModifierValue: String = accessLevelModifierArgument.toStringValue
            else {
                throw CaseDetectionMacroError.invalidAccessLevelModifierParameter
            }

            accessLevelModifier = accessLevelModifierValue

        } else {
            accessLevelModifier = "internal"
        }

        // Expression lines
        let expressionLines: [String] = try declaration.memberBlock.members
            .compactMap { member in
                guard
                    let propertyName: String = member
                        .decl
                        .as(VariableDeclSyntax.self)?
                        .bindings
                        .first?
                        .pattern.as(IdentifierPatternSyntax.self)?
                        .identifier
                        .text
                else {
                    return nil  // Omits non-property members
                }

                guard
                    let keyMacro: AttributeListSyntax.Element = member
                        .decl
                        .as(VariableDeclSyntax.self)?
                        .attributes
                        .first(where: { attribute in
                            attribute.as(AttributeSyntax.self)?.attributeName.as(IdentifierTypeSyntax.self)?.description == "MWCKey"
                        })
                else {
                    return "case \(propertyName)" // Doesn't use `MWCKey` macro
                }

                guard
                    let customKeyValue: ExprSyntax = keyMacro
                        .as(AttributeSyntax.self)?
                        .arguments?
                        .as(LabeledExprListSyntax.self)?
                        .first?
                        .expression
                else {
                    throw MemberwiseCodableMacroError.invalidKeyName
                }

                return "case \(propertyName) = \(customKeyValue)"
            }

        // Expression
        let expression: DeclSyntax = """
            \(raw: accessLevelModifier) enum CodingKeys: String, CodingKey {
                \(raw: expressionLines.joined(separator: "\n"))
            }
            """

        return [expression]
    }
}

// MARK: - Memberwise Codable Key Macro
struct MWCKeyMacro: PeerMacro {
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

    static var invalidKeyName: Self { .init("Invalid key name") }
}
