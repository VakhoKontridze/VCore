//
//  RoundCorners.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/13/21.
//

import UIKit

// MARK:- Round Corners
extension UIView {
    /// Rounds corners
    ///
    /// - Sets `clipsToBounds` to `true`
    public func roundCorners(_ corners: CACornerMask, by radius: CGFloat) {
        clipsToBounds = true
        layer.maskedCorners = corners
        layer.cornerRadius = radius
    }
}

// MARK:- CA Corner Mask Option Set
extension CACornerMask {
    /// Top corners
    ///
    /// - Includes `layerMinXMinYCorner` and  `layerMaxXMinYCorner`
    public static let layerMinYCorners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    
    /// Right corners
    ///
    /// - Includes `layerMaxXMinYCorner` and  `layerMaxXMaxYCorner`
    public static let layerMaxXCorners: CACornerMask = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    
    /// Bottom corners
    ///
    /// - Includes `layerMinXMaxYCorner` and  `layerMaxXMaxYCorner`
    public static let layerMaxYCorners: CACornerMask = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    
    /// Left corners
    ///
    /// - Includes `layerMinXMinYCorner` and  `layerMinXMaxYCorner`
    public static let layerMinXCorners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    
    /// All corners
    ///
    /// - Includes `layerMinXMinYCorner`, `layerMaxXMinYCorner`, `layerMaxXMaxYCorner`, and  `layerMinXMaxYCorner`
    public static let layerAllCorners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
}
