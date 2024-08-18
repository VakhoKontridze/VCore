//
//  Color+InitWithHex.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 20.05.23.
//

import SwiftUI
import VCoreShared

// MARK: - Color + Init with Hex - String
extension Color {
    /// Initializes `UIColor` with a hex `String`.
    ///
    /// `hex` parameter must have `6` characters.
    ///
    ///     let color: Color? = .init(hex: "#007AFF")
    ///
    public init?(
        _ colorSpace: RGBColorSpace = .sRGB,
        hex string: String,
        opacity: CGFloat = 1
    ) {
        guard let values = string._hexColorRGBValues() else { return nil }

        self.init(
            colorSpace,
            red: values.red,
            green: values.green,
            blue: values.blue,
            opacity: opacity
        )
    }
}

// MARK: - Color + Init with Hex - U Int
extension Color {
    /// Initializes `UIColor` with a hex `UInt`
    ///
    /// `hex` parameter must have `6` characters.
    ///
    ///     let color: Color? = .init(hex: 0x007AFF)
    ///
    public init?(
        _ colorSpace: RGBColorSpace = .sRGB,
        hex uInt: UInt,
        opacity: CGFloat = 1
    ) {
        guard let values = uInt._hexColorRGBValues() else { return nil }

        self.init(
            colorSpace,
            red: values.red,
            green: values.green,
            blue: values.blue,
            opacity: opacity
        )
    }
}

// MARK: - Preview
#if DEBUG

#Preview(body: {
    VStack(content: {
        Color(hex: "#007AFF")
        Color(hex: 0x007AFF)
    })
})

#endif
