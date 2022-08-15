//
//  UIView.ApplyShadow.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/9/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Apply View Shadow
extension UIView {
    /// Applies shadow to `UIView`.
    ///
    ///     view.applyShadow(
    ///         color: .black.withAlphaComponent(0.16),
    ///         radius: 5,
    ///         offset: .init(width: 0, height: 5)
    ///     )
    ///
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
    ///
    ///     view.roundCornersAndApplyShadow(
    ///         cornerRadius: 10,
    ///         color: .black.withAlphaComponent(0.16),
    ///         radius: 5,
    ///         offset: .init(width: 0, height: 5)
    ///     )
    ///
    public func roundCornersAndApplyShadow(
        cornerRadius: CGFloat,
        curve: CALayerCornerCurve = .circular,
        color: UIColor?,
        radius: CGFloat,
        offset: CGSize
    ) {
        layer.cornerRadius = cornerRadius
        layer.cornerCurve = curve
        applyShadow(
            color: color,
            radius: radius,
            offset: offset
        )
    }
}

#endif
