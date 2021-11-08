//
//  UIColor.RGBAComponents.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/8/21.
//

import UIKit

// MARK: - RGBA Components
extension UIColor {
    /// RGBA components in `UIColor`.
    public var rgbaComponents: (red: Int, green: Int, blue: Int, alpha: CGFloat)? {
        guard
            let components: [CGFloat] = cgColor.components,
            components.count == 4
        else {
            return nil
        }

        return (
            red: .init(components[0] * 255.0),
            green: .init(components[1] * 255.0),
            blue: .init(components[2] * 255.0),
            alpha: components[3]
        )
    }
}
