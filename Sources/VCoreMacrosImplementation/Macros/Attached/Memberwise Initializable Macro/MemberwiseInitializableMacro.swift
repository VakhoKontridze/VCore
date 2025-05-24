//
//  MemberwiseInitializableMacro.swift
//  VCoreMacrosImplementation
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
        
        let externalParameterNamesStrings: [String: String]
        do {
            externalParameterNamesStrings = try externalParameterNamesParameter(
                attribute: node,
                context: context
            )
        } catch {
            return []
        }
        
        let parameterDefaultValuesStrings: [String: MemberwiselnitializableParameterDefaultValue]
        do {
            parameterDefaultValuesStrings = try parameterDefaultValuesParameter(
                attribute: node,
                context: context
            )
        } catch {
            return []
        }
        
        
        let excludedParametersStrings: [String]
        do {
            excludedParametersStrings = try excludedParametersParameter(
                attribute: node,
                context: context
            )
        } catch {
            return []
        }
        
        let comment: String?
        do {
            comment = try commentParameter(
                attribute: node,
                context: context
            )
        } catch {
            return []
        }

        // Skips `enum`s
        guard
            !declaration.is(EnumDeclSyntax.self)
        else {
            let error: RawStringError = .init("'MemberwiseInitializable' macro cannot be applied to 'enum's")
            context.addDiagnostics(from: error, node: node)
            return []
        }

        // Parameters
        let parameters: [ParameterData]
        do {
            parameters = try Self.parameters(
                externalParameterNamesStrings: externalParameterNamesStrings,
                parameterDefaultValuesStrings: parameterDefaultValuesStrings,
                excludedParametersStrings: excludedParametersStrings,
                attribute: node,
                declaration: declaration,
                context: context
            )
        } catch {
            return []
        }

        // Macro expansion result
        return result(
            accessLevelModifier: accessLevelModifier,
            parameters: parameters,
            comment: comment
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

    private static func externalParameterNamesParameter(
        attribute: AttributeSyntax,
        context: some MacroExpansionContext
    ) throws -> [String: String] {
        guard
            let parameter: LabeledExprSyntax = attribute
                .arguments?
                .toArgumentListGetAssociatedValue()?
                .first(where: { $0.label?.trimmedDescription == "externalParameterNames" })
        else {
            return [:] // Default value
        }

        guard
            let dictionaryExpression: DictionaryExprSyntax = parameter
                .expression.as(DictionaryExprSyntax.self)
        else {
            let error: RawStringError = .init("Invalid 'externalParameterNames' parameter")
            context.addDiagnostics(from: error, node: parameter)
            throw error
        }
        
        guard
            let value: [String: String] = try dictionaryExpression
                .content.as(DictionaryElementListSyntax.self)?
                .reduce(into: [:], { (result, element) in
                    guard
                        let key: String = element
                            .key.as(StringLiteralExprSyntax.self)?
                            .segments
                            .first?.as(StringSegmentSyntax.self)?
                            .content
                            .trimmedDescription
                    else {
                        let error: RawStringError = .init("Invalid key")
                        context.addDiagnostics(from: error, node: element)
                        throw error
                    }
                    
                    guard
                        let value: String = element
                            .value.as(StringLiteralExprSyntax.self)?
                            .segments
                            .first?.as(StringSegmentSyntax.self)?
                            .content
                            .trimmedDescription
                    else {
                        let error: RawStringError = .init("Invalid value")
                        context.addDiagnostics(from: error, node: element)
                        throw error
                    }

                    result[key] = value
                })
        else {
            return [:] // Default value
        }

        return value
    }

    private static func parameterDefaultValuesParameter(
        attribute: AttributeSyntax,
        context: some MacroExpansionContext
    ) throws -> [String: MemberwiselnitializableParameterDefaultValue] {
        guard
            let parameter: LabeledExprSyntax = attribute
                .arguments?
                .toArgumentListGetAssociatedValue()?
                .first(where: { $0.label?.trimmedDescription == "parameterDefaultValues" })
        else {
            return [:] // Default value
        }
        
        guard
            let dictionaryExpression: DictionaryExprSyntax = parameter
                .expression.as(DictionaryExprSyntax.self)
        else {
            let error: RawStringError = .init("Invalid 'parameterDefaultValues' parameter")
            context.addDiagnostics(from: error, node: parameter)
            throw error
        }

        guard
            let value: [String: MemberwiselnitializableParameterDefaultValue] = try dictionaryExpression
                .content.as(DictionaryElementListSyntax.self)?
                .reduce(into: [:], { (result, element) in
                    guard
                        let key: String = element
                            .key.as(StringLiteralExprSyntax.self)?
                            .segments
                            .first?.as(StringSegmentSyntax.self)?
                            .content
                            .trimmedDescription
                    else {
                        let error: RawStringError = .init("Invalid key")
                        context.addDiagnostics(from: error, node: element)
                        throw error
                    }

                    let value: MemberwiselnitializableParameterDefaultValue = try {
                        if
                            let caseName: String = element
                                .value.as(FunctionCallExprSyntax.self)?
                                .calledExpression.as(MemberAccessExprSyntax.self)?
                                .declName
                                .baseName
                                .trimmedDescription,

                            caseName == "value"
                        {
                            guard
                                let value: String = element
                                    .value.as(FunctionCallExprSyntax.self)?
                                    .arguments
                                    .first?
                                    .expression
                                    .trimmedDescription
                            else {
                                let error: RawStringError = .init("Invalid value")
                                context.addDiagnostics(from: error, node: element)
                                throw error
                            }

                            return .value(value)

                        } else if
                            let caseName: String = element
                                .value.as(MemberAccessExprSyntax.self)?
                                .declName
                                .baseName
                                .trimmedDescription,

                            caseName == "omit"
                        {
                            return .omit

                        } else {
                            let error: RawStringError = .init("Invalid value")
                            context.addDiagnostics(from: error, node: element)
                            throw error
                        }
                    }()

                    result[key] = value
                })
        else {
            return [:] // Default value
        }

        return value
    }

    private static func excludedParametersParameter(
        attribute: AttributeSyntax,
        context: some MacroExpansionContext
    ) throws -> [String] {
        guard
            let parameter: LabeledExprSyntax = attribute
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
                        let error: RawStringError = .init("Invalid value")
                        context.addDiagnostics(from: error, node: element)
                        throw error
                    }

                    return value
                })
        else {
            let error: RawStringError = .init("Invalid 'excludedParameters' parameter")
            context.addDiagnostics(from: error, node: parameter)
            throw error
        }

        return value
    }

    private static func commentParameter(
        attribute: AttributeSyntax,
        context: some MacroExpansionContext
    ) throws -> String? {
        guard
            let parameter: LabeledExprSyntax = attribute
                .arguments?
                .toArgumentListGetAssociatedValue()?
                .first(where: { $0.label?.trimmedDescription == "comment" })
        else {
            return nil // Default value
        }

        guard
            let value: String = parameter
                .expression.as(StringLiteralExprSyntax.self)?
                .representedLiteralValue
        else {
            let error: RawStringError = .init("Invalid 'comment' parameter")
            context.addDiagnostics(from: error, node: parameter)
            throw error
        }

        return value
    }

    // MARK: Data
    private struct ParameterData {
        let attributes: String?

        let externalName: String?
        let name: String

        let type: String
        let _isOptional: Bool // Derived value
        let _isFunctionType: Bool // Derived value

        var defaultValue: String?
    }
    
    private static func parameters(
        externalParameterNamesStrings: [String: String],
        parameterDefaultValuesStrings: [String: MemberwiselnitializableParameterDefaultValue],
        excludedParametersStrings: [String],
        attribute: AttributeSyntax,
        declaration: some DeclGroupSyntax,
        context: some MacroExpansionContext
    ) throws -> [ParameterData] {
        // Parameters
        var parameters: [ParameterData] = try declaration
            .memberBlock
            .members
            .compactMap({
                try parameter(
                    externalParameterNamesStrings: externalParameterNamesStrings,
                    parameterDefaultValuesStrings: parameterDefaultValuesStrings,
                    member: $0,
                    context: context
                )
            })
        
        // Ensures that incorrect properties aren't being used as parameters
        if
            let name: String = externalParameterNamesStrings
                .keys
                .first(where: { name in
                    !parameters.contains(where: { $0.name == name })
                })
        {
            let error: RawStringError = .init("Invalid 'externalParameterNames' parameter. '\(name)' is not a property of the declaration.")
            context.addDiagnostics(from: error, node: attribute)
            throw error
        }
        
        if
            let name: String = parameterDefaultValuesStrings
                .keys
                .filter({ $0 != "*" })
                .first(where: { name in
                    !parameters.contains(where: { $0.name == name })
                })
        {
            let error: RawStringError = .init("Invalid 'parameterDefaultValues' parameter. '\(name)' is not a property of the declaration.")
            context.addDiagnostics(from: error, node: attribute)
            throw error
        }
        
        if
            let name: String = excludedParametersStrings
                .first(where: { name in
                    !parameters.contains(where: { $0.name == name })
                })
        {
            let error: RawStringError = .init("Invalid 'excludedParameters' parameter. '\(name)' is not a property of the declaration.")
            context.addDiagnostics(from: error, node: attribute)
            throw error
        }
        
        // Removes excluded parameters
        parameters.removeAll(where: { excludedParametersStrings.contains($0.name) })
        
        // Removes default values, if wildcard is used
        if
            let wildCardValue: MemberwiselnitializableParameterDefaultValue = parameterDefaultValuesStrings["*"]
        {
            switch wildCardValue {
            case .value(let string):
                let error: RawStringError = .init("'\(string)' can not be used as a wildcard value")
                context.addDiagnostics(from: error, node: attribute)
                throw error
                
            case .omit:
                for i in parameters.indices {
                    parameters[i].defaultValue = nil
                }
            }
        }
        
        // Result
        return parameters
    }

    private static func parameter(
        externalParameterNamesStrings: [String: String],
        parameterDefaultValuesStrings: [String: MemberwiselnitializableParameterDefaultValue],
        member: MemberBlockItemSyntax,
        context: some MacroExpansionContext
    ) throws -> ParameterData? {
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
            let error: RawStringError = .init("Only one property declaration is allowed per line")
            context.addDiagnostics(from: error, node: propertyDeclaration)
            throw error
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

        // Property type
        guard
            let propertyType: String = propertyBinding.typeAnnotation?.type.trimmedDescription
        else {
            let error: RawStringError = .init("Invalid property type")
            context.addDiagnostics(from: error, node: propertyDeclaration)
            throw error
        }

        // Function type flag
        let isPropertyFunctionType: Bool = propertyType.contains("->")

        // Parameter attributes
        let parameterAttributes: String? = {
            if isPropertyFunctionType {
                return propertyDeclaration.attributes.trimmedDescription.nonEmpty
            } else {
                return nil
            }
        }()

        // Optional flag
        let isPropertyOptional: Bool = propertyBinding.typeAnnotation?.type.is(OptionalTypeSyntax.self) == true

        // Parameter default value
        let parameterDefaultValue: String? = {
            if let specifiedDefaultValue: MemberwiselnitializableParameterDefaultValue = parameterDefaultValuesStrings[propertyName] {
                switch specifiedDefaultValue {
                case .value(let string): return string
                case .omit: return nil
                }
            } else if isPropertyConstant {
                return nil
            } else if isPropertyOptional {
                return "nil"
            } else {
                return nil
            }
        }()

        // Result
        return ParameterData(
            attributes: parameterAttributes,
            externalName: externalParameterNames,
            name: propertyName,
            type: propertyType,
            _isOptional: isPropertyOptional,
            _isFunctionType: isPropertyFunctionType,
            defaultValue: parameterDefaultValue
        )
    }

    // MARK: Result
    private static func result(
        accessLevelModifier: AccessLevelModifierKeyword,
        parameters: [ParameterData],
        comment: String?
    ) -> [DeclSyntax] {
        var result: [DeclSyntax] = []

        do {
            var string: String = ""

            if let comment {
                string.append(comment)
                string.append("\n")
            }

            string.append("\(accessLevelModifier) init(")
            string.append("\n")

            for (i, parameter) in parameters.enumerated() {
                if let attributes: String = parameter.attributes {
                    string.append("\(attributes) ")
                }

                if let externalName: String = parameter.externalName {
                    string.append("\(externalName) ")
                }

                string.append("\(parameter.name): ")

                if
                    parameter._isFunctionType,
                    !parameter._isOptional
                {
                    string.append("@escaping ")
                }

                string.append(parameter.type)

                if let defaultValue: String = parameter.defaultValue {
                    string.append(" = \(defaultValue)")
                }

                if i != parameters.count-1 { string.append(",") }

                string.append("\n")
            }

            string.append(") {")
            string.append("\n")

            for parameter in parameters {
                string.append("self.\(parameter.name) = \(parameter.name)")
                string.append("\n")
            }

            string.append("}")

            result.append("\(raw: string)")
        }

        return result
    }
}

// MARK: - Helpers
extension StringProtocol {
    // Not moved to shared package
    fileprivate var nonEmpty: Self? {
        guard !isEmpty else { return nil }
        return self
    }
}
