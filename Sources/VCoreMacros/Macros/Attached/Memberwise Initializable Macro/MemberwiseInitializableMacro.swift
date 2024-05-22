//
//  MemberwiseInitializableMacro.swift
//  VCoreMacros
//
//  Created by Vakhtang Kontridze on 22.05.24.
//

import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics

// MARK: - Memberwise Initializable Macro
struct MemberwiseInitializableMacro: MemberMacro {
    static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        // Parameters
        let accessLevelModifier: AccessLevelModifierKeyword = try accessLevelModifierParameter(node: node)
        let externalParameterNamesStrings: [String: String] = try externalParameterNamesParameter(node: node)
        let parameterDefaultValuesStrings: [String: String] = try parameterDefaultValuesParameter(node: node)
        let excludedParametersStrings: [String] = try excludedParametersParameter(node: node)

        // Skips `enum`s
        guard
            !declaration.is(EnumDeclSyntax.self)
        else {
            throw MemberwiseInitializableMacroError.cannotBeAppliedToEnums
        }

        // Parameters
        let parameters: [Parameter] = try declaration
            .memberBlock
            .members
            .compactMap { 
                try parameter(
                    externalParameterNamesStrings: externalParameterNamesStrings,
                    parameterDefaultValuesStrings: parameterDefaultValuesStrings,
                    excludedParametersStrings: excludedParametersStrings,
                    member: $0
                )
            }

        // Result
        return result(
            accessLevelModifier: accessLevelModifier,
            parameters: parameters
        )
    }

    private static func accessLevelModifierParameter(
        node: AttributeSyntax
    ) throws -> AccessLevelModifierKeyword {
        guard
            let parameter: LabeledExprSyntax = node
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
            throw MemberwiseInitializableMacroError.invalidAccessLevelModifierParameter
        }

        return value
    }

    private static func externalParameterNamesParameter(
        node: AttributeSyntax
    ) throws -> [String: String] {
        guard
            let parameter: LabeledExprSyntax = node
                .arguments?
                .toArgumentListGetAssociatedValue()?
                .first(where: { $0.label?.trimmedDescription == "externalParameterNames" })
        else {
            return [:] // Default value
        }

        guard
            let value: [String: String] = try parameter
                .expression.as(DictionaryExprSyntax.self)?
                .content.as(DictionaryElementListSyntax.self)?
                .reduce(into: [:], { (result, element) in
                    guard
                        let key: String = element
                            .key.as(StringLiteralExprSyntax.self)?
                            .segments
                            .first?.as(StringSegmentSyntax.self)?
                            .content
                            .trimmedDescription,

                        let value: String = element
                            .value.as(StringLiteralExprSyntax.self)?
                            .segments
                            .first?.as(StringSegmentSyntax.self)?
                            .content
                            .trimmedDescription
                    else {
                        throw MemberwiseInitializableMacroError.invalidExternalParameterNamesParameter
                    }

                    result[key] = value
                })
        else {
            throw MemberwiseInitializableMacroError.invalidExternalParameterNamesParameter
        }

        return value
    }

    private static func parameterDefaultValuesParameter(
        node: AttributeSyntax
    ) throws -> [String: String] {
        guard
            let parameter: LabeledExprSyntax = node
                .arguments?
                .toArgumentListGetAssociatedValue()?
                .first(where: { $0.label?.trimmedDescription == "parameterDefaultValues" })
        else {
            return [:] // Default value
        }

        guard
            let value: [String: String] = try parameter
                .expression.as(DictionaryExprSyntax.self)?
                .content.as(DictionaryElementListSyntax.self)?
                .reduce(into: [:], { (result, element) in
                    guard
                        let key: String = element
                            .key.as(StringLiteralExprSyntax.self)?
                            .segments
                            .first?.as(StringSegmentSyntax.self)?
                            .content
                            .trimmedDescription,

                        let value: String = element
                            .value.as(StringLiteralExprSyntax.self)?
                            .segments
                            .first?.as(StringSegmentSyntax.self)?
                            .content
                            .trimmedDescription
                    else {
                        throw MemberwiseInitializableMacroError.invalidParameterDefaultValuesParameter
                    }

                    result[key] = value
                })
        else {
            throw MemberwiseInitializableMacroError.invalidParameterDefaultValuesParameter
        }

        return value
    }

    private static func excludedParametersParameter(
        node: AttributeSyntax
    ) throws -> [String] {
        guard
            let parameter: LabeledExprSyntax = node
                .arguments?
                .toArgumentListGetAssociatedValue()?
                .first(where: { $0.label?.trimmedDescription == "excludedParameters" })
        else {
            return [] // Default value
        }

        guard
            let value: [String] = try parameter
                .expression.as(ArrayExprSyntax.self)?
                .elements
                .map({ element in
                    guard
                        let value: String = element
                            .expression.as(StringLiteralExprSyntax.self)?
                            .segments
                            .first?.as(StringSegmentSyntax.self)?
                            .content
                            .trimmedDescription
                    else {
                        throw MemberwiseInitializableMacroError.invalidExcludedParametersParameter
                    }

                    return value
                })
        else {
            throw MemberwiseInitializableMacroError.invalidExcludedParametersParameter
        }

        return value
    }

    private static func parameter(
        externalParameterNamesStrings: [String: String],
        parameterDefaultValuesStrings: [String: String],
        excludedParametersStrings: [String],
        member: MemberBlockItemSyntax
    ) throws -> Parameter? {
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
            throw MemberwiseInitializableMacroError.onePropertyAllowedPerLine
        }

        // Skips `lazy` properties
        guard
            !propertyDeclaration.modifiers.contains(where: { $0.name.tokenKind == .keyword(Keyword.lazy) })
        else {
            return nil
        }

        // Skips `static` properties
        guard
            !propertyDeclaration.modifiers.contains(where: { $0.name.tokenKind == .keyword(Keyword.static) })
        else {
            return nil
        }

        // Property attributes
        let propertyAttributes: String? = propertyDeclaration.attributes.trimmedDescription.nonEmpty

        // Constant flag
        let isPropertyConstant: Bool = propertyDeclaration.bindingSpecifier.tokenKind == .keyword(Keyword.let)

        // Skips stored initialized properties
        if
            isPropertyConstant &&
            propertyBinding.initializer != nil
        {
            return nil
        }

        // Skips computed properties
        guard
            propertyBinding.accessorBlock == nil
        else {
            return nil
        }

        // Property name
        let propertyName: String = propertyBinding.pattern.trimmedDescription

        // Parameter name
        let externalParameterNames: String? = {
            if let specifiedExternalParameterNames: String = externalParameterNamesStrings[propertyName] {
                return specifiedExternalParameterNames
            } else {
                return nil
            }
        }()

        // Skips excluded parameter
        guard
            !excludedParametersStrings.contains(propertyName)
        else {
            return nil
        }

        // Property type
        guard
            let propertyType: String = propertyBinding.typeAnnotation?.type.trimmedDescription
        else {
            throw MemberwiseInitializableMacroError.invalidPropertyType
        }

        // Optional flag
        let isPropertyOptional: Bool = propertyBinding.typeAnnotation?.type.is(OptionalTypeSyntax.self) == true

        // Parameter default value
        let parameterDefaultValue: String? = {
            if let specifiedDefaultValue: String = parameterDefaultValuesStrings[propertyName] {
                return specifiedDefaultValue
            } else if isPropertyConstant {
                return nil
            } else if isPropertyOptional {
                return "nil"
            } else {
                return nil
            }
        }()

        // Result
        return Parameter(
            attributes: propertyAttributes,
            externalName: externalParameterNames,
            name: propertyName,
            type: propertyType,
            _isOptional: isPropertyOptional,
            defaultValue: parameterDefaultValue
        )
    }

    private struct Parameter {
        let attributes: String?
        let externalName: String?
        let name: String
        let type: String
        let _isOptional: Bool // Derived value
        let defaultValue: String?
    }

    private static func result(
        accessLevelModifier: AccessLevelModifierKeyword,
        parameters: [Parameter]
    ) -> [DeclSyntax] {
        var result: String = ""

        result.append("\(accessLevelModifier) init(")
        result.append("\n")

        for (i, parameter) in parameters.enumerated() {
            if let attributes: String = parameter.attributes {
                result.append("\(attributes) ")
            }

            if let externalName: String = parameter.externalName {
                result.append("\(externalName) ")
            }

            result.append("\(parameter.name): ")

            if
                parameter.type.contains("->"),
                !parameter._isOptional
            {
                result.append("@escaping ")
            }

            result.append(parameter.type)

            if let defaultValue: String = parameter.defaultValue {
                result.append(" = \(defaultValue)")
            }

            if i != parameters.count-1 { result.append(",") }

            result.append("\n")
        }

        result.append(") {")
        result.append("\n")

        for parameter in parameters {
            result.append("self.\(parameter.name) = \(parameter.name)")
            result.append("\n")
        }

        result.append("}")

        return ["\(raw: result)"]
    }
}

// MARK: - Helpers
extension StringProtocol {
    // Not moved to share package
    fileprivate var nonEmpty: Self? {
        guard !isEmpty else { return nil }
        return self
    }
}
