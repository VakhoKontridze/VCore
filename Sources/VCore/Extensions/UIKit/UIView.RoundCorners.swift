//
//  UIView.RoundCorners.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/13/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Round View Corners
extension UIView {
    /// Rounds corners.
    ///
    /// Sets `clipsToBounds` to `true`.
    ///
    ///     view.roundCorners(.layerAllCorners, by: 10)
    ///
    public func roundCorners(
        _ corners: CACornerMask,
        by radius: CGFloat,
        curve: CALayerCornerCurve = .circular
    ) {
        clipsToBounds = true
        layer.maskedCorners = corners
        layer.cornerRadius = radius
        layer.cornerCurve = curve
    }
}

// MARK: - CA Corner Mask Option Set
extension CACornerMask {
    /// Top corners.
    ///
    /// Includes `layerMinXMinYCorner` and  `layerMaxXMinYCorner`.
    public static var layerMinYCorners: CACornerMask { [.layerMinXMinYCorner, .layerMaxXMinYCorner] }
    
    /// Right corners.
    ///
    /// Includes `layerMaxXMinYCorner` and  `layerMaxXMaxYCorner`.
    public static var layerMaxXCorners: CACornerMask { [.layerMaxXMinYCorner, .layerMaxXMaxYCorner] }
    
    /// Bottom corners.
    ///
    /// Includes `layerMinXMaxYCorner` and  `layerMaxXMaxYCorner`.
    public static var layerMaxYCorners: CACornerMask { [.layerMinXMaxYCorner, .layerMaxXMaxYCorner] }
    
    /// Left corners.
    ///
    /// Includes `layerMinXMinYCorner` and  `layerMinXMaxYCorner`.
    public static var layerMinXCorners: CACornerMask { [.layerMinXMinYCorner, .layerMinXMaxYCorner] }
    
    /// All corners.
    ///
    /// Includes `layerMinXMinYCorner`, `layerMaxXMinYCorner`, `layerMaxXMaxYCorner`, and  `layerMinXMaxYCorner`.
    public static var layerAllCorners: CACornerMask { [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner] }
}

#endif
