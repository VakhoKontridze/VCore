//
//  Color.InitWithHex.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 20.05.23.
//

import SwiftUI

// MARK: - Color Init with Hex (UInt64)
extension Color {
    /// Initializes `UIColor` with a hex `UInt64`
    ///
    ///     let color: Color? = .init(hex: 0x007AFF)
    ///
    public init?(
        _ colorSpace: RGBColorSpace = .sRGB,
        hex uInt: UInt64
    ) {
        guard let values = uInt.hexColorRGBAValues() else { return nil }

        self.init(
            colorSpace,
            red: values.red,
            green: values.green,
            blue: values.blue,
            opacity: values.alpha
        )
    }
}

// MARK: - Color Init with Hex (String)
extension Color {
    /// Initializes `UIColor` with a hex `String`
    ///
    ///     let color: Color? = .init(hex: "#007AFF")
    ///
    public init?(
        _ colorSpace: RGBColorSpace = .sRGB,
        hex string: String
    ) {
        guard let values = string.hexColorRGBAValues() else { return nil }

        self.init(
            colorSpace,
            red: values.red,
            green: values.green,
            blue: values.blue,
            opacity: values.alpha
        )
    }
}
