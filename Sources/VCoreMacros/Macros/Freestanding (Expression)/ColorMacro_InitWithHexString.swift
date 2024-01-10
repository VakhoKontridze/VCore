//
//  ColorMacro_InitWithHexString.swift
//  VCoreMacros
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

import SwiftUI
import SwiftSyntax
import SwiftSyntaxMacros
import VCoreShared

// MARK: - Color Macro (Init with Hex String)
struct ColorMacro_InitWithHexString: ExpressionMacro {
    static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        // `colorSpace` parameter
        let colorSpaceString: String = try {
            guard
                let argument: LabeledExprSyntax = node.argumentList.first(where: { $0.label?.text == nil })
            else {
                return "sRGB" // Default value
            }

            guard
                let value: String = argument.expression.as(MemberAccessExprSyntax.self)?
                    .declName.as(DeclReferenceExprSyntax.self)?
                    .baseName.text
            else {
                throw ColorMacroError_InitWithHexString.invalidColorSpaceParameter
            }

            return value
        }()

        // `hex` parameter
        let hex: String = try {
            guard
                let argument: LabeledExprSyntax = node.argumentList.first(where: { $0.label?.text == "hex" }),
                let value: String = argument.expression.as(StringLiteralExprSyntax.self)?.representedLiteralValue
            else {
                throw ColorMacroError_InitWithHexString.invalidHexParameter
            }

            return value
        }()

        // RGBA values
        guard
            let rgbaValues = hex._hexColorRGBAValues()
        else {
            throw ColorMacroError_InitWithHexString.invalidHexParameter
        }

        // Result
        return 
            """
            Color(
                .\(raw: colorSpaceString),
                red: \(raw: rgbaValues.red),
                green: \(raw: rgbaValues.green),
                blue: \(raw: rgbaValues.blue),
                opacity: \(raw: rgbaValues.alpha)
            )
            """
    }
}

// MARK: - Color Macro Error (Init with Hex String)
struct ColorMacroError_InitWithHexString: Error, CustomStringConvertible {
    // MARK: Properties
    let description: String

    // MARK: Initializers
    private init(
        _ description: String
    ) {
        self.description = description
    }

    static var invalidColorSpaceParameter: Self { .init("Invalid `colorSpace` parameter") }
    static var invalidHexParameter: Self { .init("Invalid 'hex' parameter") }
}
