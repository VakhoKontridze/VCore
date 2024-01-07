//
//  CaseDetectionMacro.swift
//  VCoreMacrosImplementation
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
        try declaration.memberBlock.members
            .compactMap { $0.decl.as(EnumCaseDeclSyntax.self) }
            .map { enumCase in
                guard
                    let name: TokenSyntax = enumCase.elements.first?.name
                else {
                    throw CaseDetectionMacroError.cannotRetrieveMemberName
                }

                return name
            }
            .map { name in
                let firstCharUppercasedName: String = {
                    let string: String = name.text

                    if let initial = string.first {
                        return "\(initial.uppercased())\(string.dropFirst())"
                    } else {
                        return string
                    }
                }()

                return """
                var is\(raw: firstCharUppercasedName): Bool {
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

    static var cannotRetrieveMemberName: Self { .init("Cannot retrieve member name") } // Cannot be tested
}
