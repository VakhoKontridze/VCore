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
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        // Macro parameters
        let accessLevelModifier: AccessLevelModifierKeyword
        do {
            accessLevelModifier = try accessLevelModifierParameter(
                attribute: node,
                declaration: declaration,
                context: context
            )
        } catch {
            return []
        }

        // Properties
        var properties: [PropertyData] = []
        for member in declaration.memberBlock.members {
            do {
                guard
                    let property: PropertyData = try property(
                        member: member,
                        context: context
                    )
                else {
                    continue
                }
                    
                properties.append(property)
                
            } catch {
                return []
            }
        }

        // Macro expansion result
        return result(
            accessLevelModifier: accessLevelModifier,
            properties: properties
        )
    }

    // MARK: Macro Parameters
    private static func accessLevelModifierParameter(
        attribute: AttributeSyntax,
        declaration: some DeclGroupSyntax,
        context: some MacroExpansionContext
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
            context.addDiagnostics(from: error, node: parameter)
            throw error
        }

        return value
    }

    // MARK: Data
    private struct PropertyData {
        let name: String
        let key: String
    }

    private static func property(
        member: MemberBlockItemSyntax,
        context: some MacroExpansionContext
    ) throws -> PropertyData? {
        // `CKGProperty`
        guard
            let propertyMacro: AttributeSyntax = member
                .decl.asProtocol(WithAttributesSyntax.self)?
                .attributes
                .first(where: { attribute in
                    attribute.as(AttributeSyntax.self)?
                        .attributeName.as(IdentifierTypeSyntax.self)?
                        .trimmedDescription == "CKGProperty"
                })?.as(AttributeSyntax.self)
        else {
            return nil
        }

        // Limits declaration to variables
        guard
            let propertyDeclaration: VariableDeclSyntax = member.decl.as(VariableDeclSyntax.self)
        else {
            let error: RawStringError = .init("'CKGProperty' macro can only be applied to variables")
            context.addDiagnostics(from: error, node: propertyMacro)
            throw error
        }

        // Limits declaration to one property per line
        guard
            propertyDeclaration.bindings.count == 1,
            let propertyBinding: PatternBindingListSyntax.Element = propertyDeclaration.bindings.first
        else {
            let error: RawStringError = .init("Only one property declaration is allowed per line")
            context.addDiagnostics(from: error, node: propertyMacro)
            throw error
        }

        // Skips computed properties
        guard
            propertyBinding.accessorBlock == nil
        else {
            let error: RawStringError = .init("'CKGProperty' macro can not be applied to computed properties")
            context.addDiagnostics(from: error, node: propertyMacro)
            throw error
        }

        // Property name
        guard
            let propertyName: String = propertyBinding
                .pattern.as(IdentifierPatternSyntax.self)?
                .identifier
                .trimmedDescription
        else {
            let error: RawStringError = .init("Invalid property name")
            context.addDiagnostics(from: error, node: propertyMacro)
            throw error
        }

        // Property key
        let propertyKey: String = try {
            guard
                let parameter: LabeledExprSyntax = propertyMacro
                    .arguments?.as(LabeledExprListSyntax.self)?
                    .first // Only one argument, with no name
            else {
                let error: RawStringError = .init("Invalid coding key")
                context.addDiagnostics(from: error, node: propertyMacro)
                throw error
            }

            guard
                let value: String = parameter
                    .expression.as(StringLiteralExprSyntax.self)?
                    .segments
                    .first?.as(StringSegmentSyntax.self)?
                    .content
                    .trimmedDescription
            else {
                let error: RawStringError = .init("Invalid coding key")
                context.addDiagnostics(from: error, node: propertyMacro)
                throw error
            }

            return value
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
        var result: [DeclSyntax] = []

        do {
            var string: String = ""

            string.append("\(accessLevelModifier) enum CodingKeys: String, CodingKey {")
            string.append("\n")

            for property in properties {
                string.append("case \(property.name) = \"\(property.key)\"")
                string.append("\n")
            }

            string.append("}")
            string.append("\n")

            result.append("\(raw: string)")
        }

        return result
    }
}
