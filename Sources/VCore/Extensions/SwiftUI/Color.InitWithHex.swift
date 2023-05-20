//
//  Color.InitWithHex.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 20.05.23.
//

import SwiftUI

// MARK: - Color Init with Hex
extension Color {
    /// Initializes `UIColor` with a hex string
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
