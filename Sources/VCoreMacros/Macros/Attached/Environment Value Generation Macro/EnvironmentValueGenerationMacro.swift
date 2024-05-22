//
//  EnvironmentValueMacro.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 19.04.24.
//

import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics

// MARK: - Environment Value Generation Macro
struct EnvironmentValueGenerationMacro: PeerMacro, AccessorMacro {
    // MARK: Peer Macro
    static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        // Expansion data
        let expansionData: ExpansionData = try decodeExpansion(
            attribute: node,
            declaration: declaration
        )

        // Result
        return [
            """
            private struct \(raw: expansionData.propertyName)_EnvironmentKey: EnvironmentKey {
                static let defaultValue: \(raw: expansionData.propertyType) = \(raw: expansionData.propertyDefaultValue)
            }
            """
        ]
    }

    // MARK: Accessor Macro
    static func expansion(
        of node: AttributeSyntax,
        providingAccessorsOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [AccessorDeclSyntax] {
        // Expansion data
        guard
            let expansionData: ExpansionData = try? decodeExpansion(
                attribute: node,
                declaration: declaration
            )
        else {
            return [] // Errors are thrown from `PeerMacro`
        }

        // Result
        return [
            """
            get { 
                self[\(raw: expansionData.propertyName)_EnvironmentKey.self]
            }
            """,
            """
            set { 
                self[\(raw: expansionData.propertyName)_EnvironmentKey.self] = newValue
            }
            """
        ]
    }

    // MARK: Expansion
    private struct ExpansionData {
        let propertyName: String
        let propertyType: String
        let propertyDefaultValue: String
    }

    private static func decodeExpansion(
        attribute: AttributeSyntax,
        declaration: some DeclSyntaxProtocol
    ) throws -> ExpansionData {
        // Limits declaration to variables
        guard
            let propertyDeclaration: VariableDeclSyntax = declaration.as(VariableDeclSyntax.self),
            let propertyBinding: PatternBindingListSyntax.Element = propertyDeclaration.bindings.first
        else {
            throw EnvironmentValueGenerationMacroError.canOnlyBeAppliedToProperties
        }

        // Property specifier
        guard
            let propertySpecifier: Keyword = propertyDeclaration
                .bindingSpecifier
                .tokenKind.toKeywordAssociatedValue(),
            propertySpecifier == Keyword.var
        else {
            throw EnvironmentValueGenerationMacroError.canOnlyBeAppliedToVariableProperties
        }

        // Property name
        guard
            let propertyName: String = propertyBinding
                .pattern.as(IdentifierPatternSyntax.self)?
                .identifier
                .trimmedDescription
        else {
            throw EnvironmentValueGenerationMacroError.invalidPropertyName
        }

        // Property type
        guard
            let propertyType: String = propertyBinding.typeAnnotation?.type.trimmedDescription
        else {
            throw EnvironmentValueGenerationMacroError.invalidPropertyType
        }

        // Property default value
        let propertyDefaultValue: String = try {
            if let propertyDefaultValue: String = propertyBinding.initializer?.value.trimmedDescription {
                return propertyDefaultValue
            } else if propertyBinding.typeAnnotation?.type.is(OptionalTypeSyntax.self) == true {
                return "nil"
            } else {
                throw EnvironmentValueGenerationMacroError.invalidDefaultValue
            }
        }()

        // Result
        return ExpansionData(
            propertyName: propertyName,
            propertyType: propertyType,
            propertyDefaultValue: propertyDefaultValue
        )
    }
}
