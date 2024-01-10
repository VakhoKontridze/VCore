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
                throw CaseDetectionMacroError.invalidAccessLevelModifierParameter
            }

            return value
        }()

        // Limits declaration to enums
        guard
            declaration.is(EnumDeclSyntax.self)
        else {
            throw CaseDetectionMacroError.canOnlyBeAppliedToEnums
        }

        // Enum cases
        let enumCases: [EnumCaseElementSyntax] = declaration.memberBlock.members
            .compactMap { $0.decl.as(EnumCaseDeclSyntax.self) }
            .flatMap { $0.elements } // Retrieves all cases from the same line

        // Result
        var result: [DeclSyntax] = []

        for enumCase in enumCases {
            let enumCaseName: String = enumCase.name.text.removingReservedKeywordBackticks()

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

// MARK: - Case Detection Macro Error
struct CaseDetectionMacroError: Error, CustomStringConvertible {
    // MARK: Properties
    let description: String

    // MARK: Initializers
    private init(
        _ description: String
    ) {
        self.description = description
    }

    static var invalidAccessLevelModifierParameter: Self { .init("Invalid 'accessLevelModifier' parameter") }
    static var canOnlyBeAppliedToEnums: Self { .init("'CaseDetection' macro can only be applied to an 'enum'") }
}
