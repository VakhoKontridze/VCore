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
        // Parameters
        let colorSpaceString: String = try colorSpaceParameter(node: node)
        let hex: UInt = try hexParameter(node: node)
        let opacity: CGFloat = try opacityParameter(node: node)

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

    private static func colorSpaceParameter(
        node: some FreestandingMacroExpansionSyntax
    ) throws -> String {
        guard
            let argument: LabeledExprSyntax = node
                .arguments
                .first(where: { $0.label?.trimmedDescription == nil })
        else {
            return "sRGB" // Default value
        }

        guard
            let value: String = argument
                .expression.as(MemberAccessExprSyntax.self)?
                .declName
                .baseName
                .trimmedDescription
        else {
            throw ColorMacroError_InitWithHexUInt.invalidColorSpaceParameter
        }

        return value
    }

    private static func hexParameter(
        node: some FreestandingMacroExpansionSyntax
    ) throws -> UInt {
        guard
            let argument: LabeledExprSyntax = node
                .arguments
                .first(where: { $0.label?.trimmedDescription == "hex" }),

            let valueString: String = argument
                .expression.as(IntegerLiteralExprSyntax.self)?
                .literal
                .trimmedDescription
                .replacingOccurrences(of: "0x", with: ""),

            let value: UInt = .init(valueString, radix: 16)
        else {
            throw ColorMacroError_InitWithHexUInt.invalidHexParameter
        }

        return value
    }

    private static func opacityParameter(
        node: some FreestandingMacroExpansionSyntax
    ) throws -> CGFloat {
        guard
            let argument: LabeledExprSyntax = node
                .arguments
                .first(where: { $0.label?.trimmedDescription == "opacity" })
        else {
            return 1 // Default value
        }

        guard
            let valueString: String = argument
                .expression.as(FloatLiteralExprSyntax.self)?
                .literal
                .trimmedDescription,

            let value: CGFloat = Double(valueString).map({ CGFloat($0) })
        else {
            throw ColorMacroError_InitWithHexUInt.invalidOpacityParameter
        }

        return value
    }
}
