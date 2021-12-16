//
//  UIView.ApplyShadow.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/9/21.
//

import UIKit

// MARK: - Apply View Shadow
extension UIView {
    /// Applies shadow to `UIView`.
    public func applyShadow(
        color: UIColor?,
        radius: CGFloat,
        offset: CGSize
    ) {
        layer.shadowColor = color?.cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = radius
        layer.shadowOffset = offset
    }
    
    /// Rounds corners and applies shadow to `UIView`.
    public func roundCornersAndApplyShadow(
        cornerRadius: CGFloat,
        color: UIColor?,
        radius: CGFloat,
        offset: CGSize
    ) {
        layer.cornerRadius = cornerRadius
        applyShadow(
            color: color,
            radius: radius,
            offset: offset
        )
    }
}
