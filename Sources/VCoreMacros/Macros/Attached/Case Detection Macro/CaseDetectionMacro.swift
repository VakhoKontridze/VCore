//
//  CaseDetectionMacro.swift
//  VCoreMacros
//
//  Created by Vakhtang Kontridze on 07.01.24.
//

import Foundation
import SwiftSyntax
import SwiftSyntaxMacros

// MARK: - Case Detection Macro
struct CaseDetectionMacro: MemberMacro {
    // MARK: Expansion Macro
    static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        // Parameters
        let accessLevelModifier: AccessLevelModifierKeyword = try accessLevelModifierParameter(attribute: node)

        // Limits declaration to `enum`s
        guard
            declaration.is(EnumDeclSyntax.self)
        else {
            throw CaseDetectionMacroError.canOnlyBeAppliedToEnums
        }

        // `enum` cases
        let enumCases: [EnumCaseElementSyntax] = declaration
            .memberBlock
            .members
            .compactMap { $0.decl.as(EnumCaseDeclSyntax.self) }
            .flatMap { $0.elements } // Retrieves all cases from the same line

        // Result
        return result(
            accessLevelModifier: accessLevelModifier,
            enumCases: enumCases
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
            throw CaseDetectionMacroError.invalidAccessLevelModifierParameter
        }

        return value
    }

    // MARK: Result
    private static func result(
        accessLevelModifier: AccessLevelModifierKeyword,
        enumCases: [EnumCaseElementSyntax]
    ) -> [DeclSyntax] {
        var result: [DeclSyntax] = []

        for enumCase in enumCases {
            let enumCaseName: String = enumCase.name.trimmedDescription.removingReservedKeywordBackticks()

            let firstCharUppercasedName: String = {
                if let firstChar: Character = enumCaseName.first {
                    return "\(firstChar.uppercased())\(enumCaseName.dropFirst())"
                } else {
                    return enumCaseName
                }
            }()

            result.append(
                """
                \(raw: accessLevelModifier) var is\(raw: firstCharUppercasedName): Bool {
                    if case .\(raw: enumCaseName) = self {
                        true
                    } else {
                        false
                    }
                }
                """
            )
        }

        return result
    }
}
