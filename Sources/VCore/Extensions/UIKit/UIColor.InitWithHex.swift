//
//  UIColor.InitWithHex.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 20.05.23.
//

#if canImport(UIKit)

import UIKit

// MARK: - Color Init with Hex
extension UIColor {
    /// Initializes `UIColor` with a hex string
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
extension String {
    /*fileprivate*/ func hexColorRGBAValues() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        let string: String = {
            var string: String = trimmingCharacters(in: .whitespacesAndNewlines)

            if string.hasPrefix("#") {
                _ = string.removeFirst()
            }

            return string
        }()

        switch string.count {
        case 2:
            let color: UInt64 = string.scanHexColorStringToInt()
            let mask: Int = 0xFF

            let gray: CGFloat = CGFloat(Int(color) & mask) / 255

            return (gray, gray, gray, 1)

        case 4:
            let color: UInt64 = string.scanHexColorStringToInt()
            let mask: Int = 0x00FF

            let gray: CGFloat = CGFloat(Int(color >> 8) & mask) / 255
            let alpha: CGFloat = CGFloat(Int(color) & mask) / 255

            return (gray, gray, gray, alpha)

        case 6:
            let color: UInt64 = string.scanHexColorStringToInt()
            let mask: Int = 0x00_00FF

            let red: CGFloat = CGFloat(Int(color >> 16) & mask) / 255
            let green: CGFloat = CGFloat(Int(color >> 8) & mask) / 255
            let blue: CGFloat = CGFloat(Int(color) & mask) / 255

            return (red, green, blue, 1)

        case 8:
            let color: UInt64 = string.scanHexColorStringToInt()
            let mask: Int = 0x0000_00FF

            let red: CGFloat = CGFloat(Int(color >> 24) & mask) / 255
            let green: CGFloat = CGFloat(Int(color >> 16) & mask) / 255
            let blue: CGFloat = CGFloat(Int(color >> 8) & mask) / 255
            let alpha: CGFloat = CGFloat(Int(color) & mask) / 255

            return (red, green, blue, alpha)

        default:
            return nil
        }
    }

    private func scanHexColorStringToInt() -> UInt64 {
        let scanner: Scanner = .init(string: self)

        var color: UInt64 = 0
        scanner.scanHexInt64(&color)

        return color
    }
}
