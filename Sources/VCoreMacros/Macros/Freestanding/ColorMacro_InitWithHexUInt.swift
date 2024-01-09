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
                let argument: LabeledExprSyntax = node.argumentList.first(where: { $0.label?.text == nil })
            else {
                return "sRGB" // Default value
            }

            guard
                let value: String = argument.expression.as(MemberAccessExprSyntax.self)?
                    .declName.as(DeclReferenceExprSyntax.self)?
                    .baseName.text
            else {
                throw ColorMacroError_InitWithHexUInt.invalidColorSpaceParameter
            }

            return value
        }()

        // `hex` parameter
        let hex: UInt = try {
            guard
                let argument: LabeledExprSyntax = node.argumentList.first(where: { $0.label?.text == "hex" }),
                let valueString: String = argument.expression.as(IntegerLiteralExprSyntax.self)?.literal.text
                    .replacingOccurrences(of: "0x", with: ""),
                let value: UInt = .init(valueString, radix: 16)
            else {
                throw ColorMacroError_InitWithHexString.invalidHexParameter
            }

            return value
        }()

        // `opacity` parameter
        let opacity: CGFloat = try {
            guard
                let argument: LabeledExprSyntax = node.argumentList.first(where: { $0.label?.text == "opacity" })
            else {
                return 1 // Default value
            }

            guard
                let valueString: String = argument.expression.as(FloatLiteralExprSyntax.self)?.literal.text,
                let value: CGFloat = Double(valueString).map({ CGFloat($0) })
            else {
                throw ColorMacroError_InitWithHexString.invalidColorSpaceParameter
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

// MARK: - Color Macro Error (Init with Hex UInt)
struct ColorMacroError_InitWithHexUInt: Error, CustomStringConvertible {
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
    static var invalidOpacityParameter: Self { .init("Invalid 'opacity' parameter") }
}
