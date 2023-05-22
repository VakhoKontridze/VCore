//
//  UIColor.InitWithHex.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 20.05.23.
//

#if canImport(UIKit)

import UIKit

// MARK: - Color Init with Hex (UInt64)
extension UIColor {
    /// Initializes `UIColor` with a hex `UInt64`
    ///
    ///     let color: UIColor? = .init(hex: 0x007AFF)
    ///
    public convenience init?(hex uInt: UInt64) {
        guard let values = uInt.hexColorRGBAValues() else { return nil }

        self.init(
            red: values.red,
            green: values.green,
            blue: values.blue,
            alpha: values.alpha
        )
    }

    /// Initializes `UIColor` with a hex string
    ///
    ///     let color: UIColor? = .init(displayP3Hex: 0x007AFF)
    ///
    public convenience init?(displayP3Hex uInt: UInt64) {
        guard let values = uInt.hexColorRGBAValues() else { return nil }

        self.init(
            displayP3Red: values.red,
            green: values.green,
            blue: values.blue,
            alpha: values.alpha
        )
    }
}

// MARK: - Color Init with Hex (String)
extension UIColor {
    /// Initializes `UIColor` with a hex `String`
    ///
    ///     let color: UIColor? = .init(hex: "#007AFF")
    ///
    public convenience init?(hex string: String) {
        guard let values = string.hexColorRGBAValues() else { return nil }

        self.init(
            red: values.red,
            green: values.green,
            blue: values.blue,
            alpha: values.alpha
        )
    }

    /// Initializes `UIColor` with a hex string
    ///
    ///     let color: UIColor? = .init(displayP3Hex: "#007AFF")
    ///
    public convenience init?(displayP3Hex string: String) {
        guard let values = string.hexColorRGBAValues() else { return nil }

        self.init(
            displayP3Red: values.red,
            green: values.green,
            blue: values.blue,
            alpha: values.alpha
        )
    }
}

#endif

// MARK: - Helpers
extension UInt64 {
    /*fileprivate*/ func hexColorRGBAValues() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        switch String(self, radix: 16).count {
        case 2:
            let mask: Int = 0xFF

            let gray: CGFloat = CGFloat(Int(self) & mask) / 255

            return (gray, gray, gray, 1)

        case 4:
            let mask: Int = 0x00FF

            let gray: CGFloat = CGFloat(Int(self >> 8) & mask) / 255
            let alpha: CGFloat = CGFloat(Int(self) & mask) / 255

            return (gray, gray, gray, alpha)

        case 6:
            let mask: Int = 0x00_00FF

            let red: CGFloat = CGFloat(Int(self >> 16) & mask) / 255
            let green: CGFloat = CGFloat(Int(self >> 8) & mask) / 255
            let blue: CGFloat = CGFloat(Int(self) & mask) / 255

            return (red, green, blue, 1)

        case 8:
            let mask: Int = 0x0000_00FF

            let red: CGFloat = CGFloat(Int(self >> 24) & mask) / 255
            let green: CGFloat = CGFloat(Int(self >> 16) & mask) / 255
            let blue: CGFloat = CGFloat(Int(self >> 8) & mask) / 255
            let alpha: CGFloat = CGFloat(Int(self) & mask) / 255

            return (red, green, blue, alpha)

        default:
            return nil
        }
    }
}

extension String {
    /*fileprivate*/ func hexColorRGBAValues() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        let string: String = {
            var string: String = trimmingCharacters(in: .whitespacesAndNewlines)

            if string.hasPrefix("#") {
                _ = string.removeFirst()
            }

            return string
        }()

        let color: UInt64 = string.scanHexColorStringToInt()

        return color.hexColorRGBAValues()
    }

    private func scanHexColorStringToInt() -> UInt64 {
        let scanner: Scanner = .init(string: self)

        var color: UInt64 = 0
        scanner.scanHexInt64(&color)

        return color
    }
}
