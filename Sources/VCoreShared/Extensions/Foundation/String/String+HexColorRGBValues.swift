//
//  String+HexColorRGBValues.swift
//  VCoreShared
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

import Foundation

// MARK: - String + Hex Color RGB Values
extension String {
    package func _hexColorRGBValues() -> (red: CGFloat, green: CGFloat, blue: CGFloat)? {
        var string: String = trimmingCharacters(in: .whitespacesAndNewlines)
        if string.hasPrefix("#") { _ = string.removeFirst() }

        guard string.count == 6 else { return nil }

        let int: UInt64 = string.scanHexColorStringToUInt64()

        let mask: Int = 0x00_00FF

        let red: CGFloat = CGFloat(Int(int >> 16) & mask) / 255
        let green: CGFloat = CGFloat(Int(int >> 8) & mask) / 255
        let blue: CGFloat = CGFloat(Int(int) & mask) / 255

        return (red, green, blue)
    }

    private func scanHexColorStringToUInt64() -> UInt64 {
        let scanner: Scanner = .init(string: self)

        var color: UInt64 = 0
        scanner.scanHexInt64(&color)

        return color
    }
}
