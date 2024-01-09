//
//  ColorMacro_InitWithHexUInt.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

import SwiftUI

// MARK: - Color Macro (Init with Hex UInt)
/// Returns non-optional `Color` from `UInt`, checked during the compile time.
///
/// `hex` parameter must have at least `6` digits.
/// Everything before the first `6` will be dropped.
///
///     let color: Color = #color(hex: 0x007AFF)
///
@freestanding(expression)
public macro color(
    _ colorSpace: Color.RGBColorSpace = .sRGB,
    hex uInt: UInt,
    opacity: CGFloat = 1
) -> Color = #externalMacro(
    module: "VCoreMacros",
    type: "ColorMacro_InitWithHexUInt64"
)
