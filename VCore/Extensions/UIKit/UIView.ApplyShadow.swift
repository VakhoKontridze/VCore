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
        opacity: CGFloat = 1,
        radius: CGFloat,
        offset: CGSize
    ) {
        layer.shadowColor = color?.cgColor
        layer.shadowOpacity = .init(opacity)
        layer.shadowRadius = radius
        layer.shadowOffset = offset
    }
    
    /// Applies shadow to `UIView` and round corners.
    public func applyShadowAndRoundCorners(
        cornerRadius: CGFloat,
        color: UIColor?,
        opacity: CGFloat = 1,
        radius: CGFloat,
        offset: CGSize
    ) {
        layer.cornerRadius = cornerRadius
        applyShadow(
            color: color,
            opacity: opacity,
            radius: radius,
            offset: offset
        )
    }
}
