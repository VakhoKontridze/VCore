//
//  UIColor+InitWithHex.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 20.05.23.
//

#if canImport(UIKit)

import UIKit
import VCoreShared

nonisolated extension UIColor {
    /// Initializes `UIColor` with a hex `String`.
    ///
    /// `hex` parameter must have `6` characters.
    ///
    ///     let color: UIColor? = .init(hex: "#007AFF")
    ///
    convenience public init?(
        hex string: String,
        alpha: CGFloat = 1
    ) {
        guard let values = string._hexColorRGBValues() else { return nil }

        self.init(
            red: values.red,
            green: values.green,
            blue: values.blue,
            alpha: alpha
        )
    }

    /// Initializes `UIColor` with a hex `String`.
    ///
    /// `displayP3Hex` parameter must have `6` characters.
    ///
    ///     let color: UIColor? = .init(displayP3Hex: "#007AFF")
    ///
    convenience public init?(
        displayP3Hex string: String,
        alpha: CGFloat = 1
    ) {
        guard let values = string._hexColorRGBValues() else { return nil }

        self.init(
            displayP3Red: values.red,
            green: values.green,
            blue: values.blue,
            alpha: alpha
        )
    }
}

nonisolated extension UIColor {
    /// Initializes `UIColor` with a hex `UInt`.
    ///
    /// `hex` parameter must have `6` digits.
    ///
    ///     let color: UIColor = .init(hex: 0x007AFF)
    ///
    convenience public init(
        hex uInt: UInt,
        alpha: CGFloat = 1
    ) {
        let values = uInt._hexColorRGBValues()

        self.init(
            red: values.red,
            green: values.green,
            blue: values.blue,
            alpha: alpha
        )
    }

    /// Initializes `UIColor` with a hex `UInt`.
    ///
    /// `displayP3Hex` parameter must have `6` digits.
    ///
    ///     let color: UIColor = .init(displayP3Hex: 0x007AFF)
    ///
    convenience public init(
        displayP3Hex uInt: UInt,
        alpha: CGFloat = 1
    ) {
        let values = uInt._hexColorRGBValues()

        self.init(
            displayP3Red: values.red,
            green: values.green,
            blue: values.blue,
            alpha: alpha
        )
    }
}

#if DEBUG

import SwiftUI

#Preview {
    VStack {
        if let uiColor: UIColor = .init(hex: "#007AFF") {
            Color(uiColor: uiColor)
        }
        
        Color(uiColor: UIColor(hex: 0x007AFF))
    }
}

#endif

#endif
