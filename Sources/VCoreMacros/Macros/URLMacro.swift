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
        // Parameter - urlString
        let (urlStringArgument, urlString): (LabeledExprSyntax, String) = try {
            guard
                let argument: LabeledExprSyntax = node.argumentList.first,
                let value: String = argument.toStringValue
            else {
                throw URLMacroError.invalidURLStringParameter
            }

            return (argument, value)
        }()

        // Check
        guard
            let _: URL = .init(string: urlString)
        else {
            throw URLMacroError.malformedURL
        }

        // Expression
        return "URL(string: \(urlStringArgument.expression))!" // Force-unwrap
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
