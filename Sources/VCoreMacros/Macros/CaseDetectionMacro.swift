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
        // Parameter - accessLevelModifier
        let accessLevelModifier: String = try {
            guard
                let argument: LabeledExprSyntax? = node.arguments?.toArgumentListGetAssociatedValue()?.first
            else {
                return "internal" // Macro has a default value
            }

            guard
                let value: String = argument?.toStringValue
            else {
                throw CaseDetectionMacroError.invalidAccessLevelModifierParameter
            }

            return value
        }()

        // Enum name
        guard
            let enumDeclaration: EnumDeclSyntax = declaration.as(EnumDeclSyntax.self)
        else {
            throw CaseDetectionMacroError.canOnlyBeAppliedToEnums
        }

        let enumName: String = enumDeclaration.name.text

        // Enum case names
        let enumCaseNames: [String] = try declaration.memberBlock.members
            .compactMap { $0.decl.as(EnumCaseDeclSyntax.self) } // Omits non-case members
            .map { enumCase in
                guard
                    let enumCaseNameToken: TokenSyntax = enumCase.elements.first?.name
                else {
                    throw CaseDetectionMacroError.invalidCaseName
                }

                return enumCaseNameToken.text.removingReservedKeywordBackticks()
            }

        // Expression
        return enumCaseNames.map { name in
            let firstCharUppercasedName: String = {
                if let firstChar: Character = name.first {
                    return "\(firstChar.uppercased())\(name.dropFirst())"
                } else {
                    return name
                }
            }()

            return """
                /// Indicates if `\(raw: enumName)` is `\(raw: name)`.
                \(raw: accessLevelModifier) var is\(raw: firstCharUppercasedName): Bool {
                    if case .\(raw: name) = self {
                        true
                    } else {
                        false
                    }
                }
                """
        }
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

    static var invalidAccessLevelModifierParameter: Self { .init("Invalid access level modifier parameter") }
    static var canOnlyBeAppliedToEnums: Self { .init("'CaseDetection' macro can only be applied to an 'enum'") }
    static var invalidCaseName: Self { .init("Invalid case name") }
}
