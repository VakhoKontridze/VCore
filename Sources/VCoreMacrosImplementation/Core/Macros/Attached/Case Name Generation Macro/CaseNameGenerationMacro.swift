//
//  CaseNameGenerationMacro.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28/4/26.
//

#if !(os(iOS) || os(tvOS) || os(watchOS) || os(visionOS))

import Foundation
import SwiftSyntax
import SwiftSyntaxMacros
import VCoreShared

nonisolated struct CaseNameGenerationMacro: MemberMacro {
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
        
        let isNonIsolated: Bool = isNonIsolated(
            declaration: declaration
        )
        
        // Limits declaration to `enum`s
        guard
            declaration.is(EnumDeclSyntax.self)
        else {
            let error: RawStringError = .init("'CaseNameGeneration' macro can only be applied to 'enum's")
            context.addDiagnostics(from: error, node: declaration)
            return []
        }
        
        // Cases
        var cases: [CaseData] = []
        for member in declaration.memberBlock.members {
            do {
                guard
                    let cases_: [CaseData] = try self.cases(
                        member: member,
                        context: context
                    )
                else {
                    continue
                }
                    
                cases.append(contentsOf: cases_)
                
            } catch {
                return []
            }
        }
        
        // Result
        return result(
            accessLevelModifier: accessLevelModifier,
            isNonIsolated: isNonIsolated,
            cases: cases
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
            let inheritedValue: AccessLevelModifierKeyword? = .allCases.first { aCase in
                declaration.modifiers.contains { modifier in
                    modifier.name.tokenKind.toKeywordAssociatedValue() == aCase.swiftSyntaxKeyword
                }
            }

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
    
    private static func isNonIsolated(
        declaration: some DeclGroupSyntax
    ) -> Bool {
        declaration.modifiers.contains { $0.name.tokenKind == .keyword(.nonisolated) }
    }
    
    // MARK: Result
    private static func result(
        accessLevelModifier: AccessLevelModifierKeyword,
        isNonIsolated: Bool,
        cases: [CaseData]
    ) -> [DeclSyntax] {
        var result: [DeclSyntax] = []
        
        let prefixMethod: String = "\(accessLevelModifier) "
        let prefixType: String = "\(accessLevelModifier)\(isNonIsolated ? " nonisolated" : "") "
        
        do {
            var string: String = ""
            
            string.append("\(prefixMethod)func toName() -> Name {")
            string.append("\n")
            
            string.append("switch self {")
            string.append("\n")
            
            for `case` in cases {
                string.append("case .\(`case`.name): .\(`case`.name)")
                string.append("\n")
            }
            
            string.append("}")
            string.append("\n")
            
            string.append("}")
            string.append("\n")

            result.append("\(raw: string)")
        }
        
        do {
            var string: String = ""
            
            string.append("\(prefixMethod)func `is`(_ name: Name) -> Bool {")
            string.append("\n")
            
            string.append("toName() == name")
            string.append("\n")
            
            string.append("}")
            string.append("\n")

            result.append("\(raw: string)")
        }
        
        do {
            var string: String = ""
            
            string.append("\(prefixType)enum Name: CaseIterable {")
            string.append("\n")
            
            for `case` in cases {
                string.append("case \(`case`.name)")
                string.append("\n")
            }
            
            string.append("}")
            string.append("\n")

            result.append("\(raw: string)")
        }
        
        return result
    }
    
    // MARK: Cases
    private static func cases(
        member: MemberBlockItemSyntax,
        context: some MacroExpansionContext
    ) throws -> [CaseData]? {
        // Limits declaration to `case`s
        guard
            let enumCaseDeclaration: EnumCaseDeclSyntax = member.decl.as(EnumCaseDeclSyntax.self)
        else {
            return nil
        }
        
        // Collects results
        var result: [CaseData] = []
        
        for element in enumCaseDeclaration.elements {
            // Name
            let caseName: String = element.name.trimmedDescription
            
            // Result
            result.append(
                CaseData(
                    name: caseName
                )
            )
        }
        
        // Result
        return result
    }
    
    // MARK: Types
    nonisolated private struct CaseData {
        let name: String
    }
}

#endif
