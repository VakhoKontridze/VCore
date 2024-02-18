//
//  ColorMacro_InitWithHexString.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

import SwiftUI

// MARK: - Color Macro (Init with Hex String)
/// Returns non-optional `Color` from `String`, checked during the compile time.
///
/// `hex` parameter must have `6` characters.
///
///     let color: Color = #color(hex: "#007AFF")
///
@freestanding(expression)
public macro color(
    _ colorSpace: Color.RGBColorSpace = .sRGB,
    hex string: String,
    opacity: CGFloat = 1
) -> Color = #externalMacro(
    module: "VCoreMacros",
    type: "ColorMacro_InitWithHexString"
)
