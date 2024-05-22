//
//  URLMacro_InitWithString.swift
//  VCoreMacros
//
//  Created by Vakhtang Kontridze on 07.01.24.
//

import Foundation
import SwiftSyntax
import SwiftSyntaxMacros

// MARK: - URL Macro (Init with String)
struct URLMacro_InitWithString: ExpressionMacro {
    static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        // Parameters
        let (urlString, urlStringExpression): (String, ExprSyntax) = try urlStringParameter(node: node)

        // Checks compilation
        guard
            URL(string: urlString) != nil
        else {
            throw URLMacroError_InitWithString.malformedURL
        }

        // Result
        return "URL(string: \(urlStringExpression))!" // Force-unwrap
    }

    private static func urlStringParameter(
        node: some FreestandingMacroExpansionSyntax
    ) throws -> (String, ExprSyntax) {
        guard
            let parameter: LabeledExprSyntax = node
                .arguments
                .first, // Only one argument, with no name

            let value: String = parameter
                .expression.as(StringLiteralExprSyntax.self)?
                .representedLiteralValue
        else {
            throw URLMacroError_InitWithString.invalidURLStringParameter
        }

        return (value, parameter.expression)
    }
}
