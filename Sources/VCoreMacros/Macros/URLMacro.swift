//
//  URLMacro.swift
//  VCoreMacros
//
//  Created by Vakhtang Kontridze on 07.01.24.
//

import Foundation
import SwiftSyntax
import SwiftSyntaxMacros

// MARK: - URL Macro
struct URLMacro: ExpressionMacro {
    static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        // `urlString` parameter
        let (urlString, urlStringExpression): (String, ExprSyntax) = try {
            guard
                let argument: LabeledExprSyntax = node.argumentList.first, // Only one argument, with no name
                let value: String = argument.expression.as(StringLiteralExprSyntax.self)?.representedLiteralValue
            else {
                throw URLMacroError.invalidURLStringParameter
            }

            return (value, argument.expression)
        }()

        // Checks compilation
        guard
            let _: URL = .init(string: urlString)
        else {
            throw URLMacroError.malformedURL
        }

        // Result
        return "URL(string: \(urlStringExpression))!" // Force-unwrap
    }
}

// MARK: - URL Macro Error
struct URLMacroError: Error, CustomStringConvertible {
    // MARK: Properties
    let description: String

    // MARK: Initializers
    private init(
        _ description: String
    ) {
        self.description = description
    }

    static var invalidURLStringParameter: Self { .init("Invalid 'URL' 'String' parameter") }
    static var malformedURL: Self { .init("Malformed 'URL'") }
}
