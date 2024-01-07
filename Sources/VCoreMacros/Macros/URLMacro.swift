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
        guard
            let argument: ExprSyntax = node.argumentList.first?.expression,
            let segments: StringLiteralSegmentListSyntax = argument.as(StringLiteralExprSyntax.self)?.segments,
            segments.count == 1,
            case .stringSegment(let literalSegment)? = segments.first
        else {
            throw URLMacroError.stringLiteralRequired
        }

        guard 
            let _: URL = .init(string: literalSegment.content.text)
        else {
            throw URLMacroError.malformedURL
        }

        return "URL(string: \(argument))!" // Force-unwrap
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

    static var stringLiteralRequired: Self { .init("'String' literal is required to create an 'URL'") }
    static var malformedURL: Self { .init("Malformed 'URL'") }
}
