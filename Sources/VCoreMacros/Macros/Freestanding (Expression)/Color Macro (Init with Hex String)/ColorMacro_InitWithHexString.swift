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
                let argument: LabeledExprSyntax = node.arguments.first(where: { $0.label?.text == nil })
            else {
                return "sRGB" // Default value
            }

            guard
                let value: String = argument.expression.as(MemberAccessExprSyntax.self)?
                    .declName
                    .baseName.text
            else {
                throw ColorMacroError_InitWithHexString.invalidColorSpaceParameter
            }

            return value
        }()

        // `hex` parameter
        let hex: String = try {
            guard
                let argument: LabeledExprSyntax = node.arguments.first(where: { $0.label?.text == "hex" }),
                let value: String = argument.expression.as(StringLiteralExprSyntax.self)?.representedLiteralValue
            else {
                throw ColorMacroError_InitWithHexString.invalidHexParameter
            }

            return value
        }()

        // `opacity` parameter
        let opacity: CGFloat = try {
            guard
                let argument: LabeledExprSyntax = node.arguments.first(where: { $0.label?.text == "opacity" })
            else {
                return 1 // Default value
            }

            guard
                let valueString: String = argument.expression.as(FloatLiteralExprSyntax.self)?.literal.text,
                let value: CGFloat = Double(valueString).map({ CGFloat($0) })
            else {
                throw ColorMacroError_InitWithHexUInt.invalidOpacityParameter
            }

            return value
        }()

        // RGB values
        guard
            let rgbValues = hex._hexColorRGBValues()
        else {
            throw ColorMacroError_InitWithHexString.invalidHexParameter
        }

        // Result
        return 
            """
            Color(
                .\(raw: colorSpaceString),
                red: \(raw: rgbValues.red),
                green: \(raw: rgbValues.green),
                blue: \(raw: rgbValues.blue),
                opacity: \(raw: opacity)
            )
            """
    }
}
