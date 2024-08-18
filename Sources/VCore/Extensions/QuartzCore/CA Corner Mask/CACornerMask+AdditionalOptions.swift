//
//  CACornerMask+AdditionalOptions.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.06.22.
//

#if canImport(QuartzCore)

import QuartzCore

// MARK: - CA Corner Mask + Additional Options
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
