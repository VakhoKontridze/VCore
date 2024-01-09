//
//  UIColor.InitWithHex.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 20.05.23.
//

#if canImport(UIKit)

import UIKit
import VCoreShared

// MARK: - Color Init with Hex (String)
extension UIColor {
    /// Initializes `UIColor` with a hex `String`.
    ///
    /// `hex` parameter must have `2`, `4`, `6`, or `8`-digits.
    ///
    ///     let color: UIColor? = .init(hex: "#007AFF")
    ///
    public convenience init?(
        hex string: String
    ) {
        guard let values = string._hexColorRGBAValues() else { return nil }

        self.init(
            red: values.red,
            green: values.green,
            blue: values.blue,
            alpha: values.alpha
        )
    }

    /// Initializes `UIColor` with a hex `String`.
    ///
    /// `displayP3Hex` parameter must be in a `2`, `4`, `6`, or `8`-digit format.
    ///
    ///     let color: UIColor? = .init(displayP3Hex: "#007AFF")
    ///
    public convenience init?(
        displayP3Hex string: String
    ) {
        guard let values = string._hexColorRGBAValues() else { return nil }

        self.init(
            displayP3Red: values.red,
            green: values.green,
            blue: values.blue,
            alpha: values.alpha
        )
    }
}

// MARK: - Color Init with Hex (UInt)
extension UIColor {
    /// Initializes `UIColor` with a hex `UInt`.
    ///
    /// `hex` parameter must have at least `6` digits.
    /// All digits before the last `6` will be dropped.
    ///
    ///     let color: UIColor? = .init(hex: 0x007AFF)
    ///
    public convenience init?(
        hex uInt: UInt,
        alpha: CGFloat = 1
    ) {
        guard let values = uInt._hexColorRGBValues() else { return nil }

        self.init(
            red: values.red,
            green: values.green,
            blue: values.blue,
            alpha: alpha
        )
    }

    /// Initializes `UIColor` with a hex `UInt`.
    ///
    /// `displayP3Hex` parameter must be in a `6`-digit format.
    ///
    ///     let color: UIColor? = .init(displayP3Hex: 0x007AFF)
    ///
    public convenience init?(
        displayP3Hex uInt: UInt,
        alpha: CGFloat = 1
    ) {
        guard let values = uInt._hexColorRGBValues() else { return nil }

        self.init(
            displayP3Red: values.red,
            green: values.green,
            blue: values.blue,
            alpha: alpha
        )
    }
}

#endif
