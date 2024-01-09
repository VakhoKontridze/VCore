//
//  String.HexColorRGBAValues.swift
//  VCoreShared
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

import Foundation

// MARK: - String Hex Color RGBA Values
extension String {
    package func _hexColorRGBAValues() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var string: String = trimmingCharacters(in: .whitespacesAndNewlines)
        if string.hasPrefix("#") { _ = string.removeFirst() }

        let int: UInt64 = string.scanHexColorStringToUInt64()

        switch string.count {
        case 2:
            let mask: Int = 0xFF

            let gray: CGFloat = CGFloat(Int(int) & mask) / 255

            return (gray, gray, gray, 1)

        case 4:
            let mask: Int = 0x00FF

            let gray: CGFloat = CGFloat(Int(int >> 8) & mask) / 255
            let alpha: CGFloat = CGFloat(Int(int) & mask) / 255

            return (gray, gray, gray, alpha)

        case 6:
            let mask: Int = 0x00_00FF

            let red: CGFloat = CGFloat(Int(int >> 16) & mask) / 255
            let green: CGFloat = CGFloat(Int(int >> 8) & mask) / 255
            let blue: CGFloat = CGFloat(Int(int) & mask) / 255

            return (red, green, blue, 1)

        case 8:
            let mask: Int = 0x0000_00FF

            let red: CGFloat = CGFloat(Int(int >> 24) & mask) / 255
            let green: CGFloat = CGFloat(Int(int >> 16) & mask) / 255
            let blue: CGFloat = CGFloat(Int(int >> 8) & mask) / 255
            let alpha: CGFloat = CGFloat(Int(int) & mask) / 255

            return (red, green, blue, alpha)

        default:
            return nil
        }
    }

    private func scanHexColorStringToUInt64() -> UInt64 {
        let scanner: Scanner = .init(string: self)

        var color: UInt64 = 0
        scanner.scanHexInt64(&color)

        return color
    }
}

// MARK: - UInt Hex Color RGB Values
extension UInt {
    package func _hexColorRGBValues() -> (red: CGFloat, green: CGFloat, blue: CGFloat)? {
        let red: CGFloat = CGFloat((self & 0xFF0000) >> 16) / 255
        let green: CGFloat = CGFloat((self & 0x00FF00) >> 8) / 255
        let blue: CGFloat = CGFloat(self & 0x0000FF) / 255

        return (red, green, blue)
    }
}
