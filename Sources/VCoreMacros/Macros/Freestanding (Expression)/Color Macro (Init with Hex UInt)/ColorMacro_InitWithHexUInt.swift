//
//  ColorMacro_InitWithHexUInt.swift
//  VCoreMacros
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

import SwiftUI
import SwiftSyntax
import SwiftSyntaxMacros
import VCoreShared

// MARK: - Color Macro (Init with Hex UInt)
struct ColorMacro_InitWithHexUInt: ExpressionMacro {
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
                throw ColorMacroError_InitWithHexUInt.invalidColorSpaceParameter
            }

            return value
        }()

        // `hex` parameter
        let hex: UInt = try {
            guard
                let argument: LabeledExprSyntax = node.arguments.first(where: { $0.label?.text == "hex" }),
                let valueString: String = argument.expression.as(IntegerLiteralExprSyntax.self)?.literal.text
                    .replacingOccurrences(of: "0x", with: ""),
                let value: UInt = .init(valueString, radix: 16)
            else {
                throw ColorMacroError_InitWithHexUInt.invalidHexParameter
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
            throw ColorMacroError_InitWithHexUInt.invalidHexParameter
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
