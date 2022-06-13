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

#endif
