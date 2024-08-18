//
//  UInt+HexColorRGBAValues.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 19.08.24.
//

import Foundation

// MARK: - U Int + Hex Color RGB Values
extension UInt {
    package func _hexColorRGBValues() -> (red: CGFloat, green: CGFloat, blue: CGFloat)? {
        let red: CGFloat = CGFloat((self & 0xFF0000) >> 16) / 255
        let green: CGFloat = CGFloat((self & 0x00FF00) >> 8) / 255
        let blue: CGFloat = CGFloat(self & 0x0000FF) / 255

        return (red, green, blue)
    }
}

