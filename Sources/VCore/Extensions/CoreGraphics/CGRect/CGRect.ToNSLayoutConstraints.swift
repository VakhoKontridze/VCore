//
//  CGRect.ToNSLayoutConstraints.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.22.
//

import CoreGraphics

// MARK: - CGRect to NSLayoutConstraints
extension CGRect {
    /// Converts rect to constant usable for creating left constraint.
    ///
    ///     let constant: CGFloat = rect.leftConstraintConstant
    ///
    public var leftConstraintConstant: CGFloat {
        origin.x
    }
    
    /// Converts rect to constant usable for creating right constraint.
    ///
    ///     let constant: CGFloat = rect.rightConstraintConstant(in: view.frame.size.width)
    ///
    public func rightConstraintConstant(in width: CGFloat) -> CGFloat {
        width - size.width - origin.x
    }
    
    /// Converts rect to constant usable for creating top constraint.
    ///
    ///     let constant: CGFloat = rect.topConstraintConstant
    ///
    public var topConstraintConstant: CGFloat {
        origin.y
    }
    
    /// Converts rect to constant usable for creating bottom constraint.
    ///
    ///     let constant: CGFloat = rect.bottomConstraintConstant(in: view.frame.size.height)
    ///
    public func bottomConstraintConstant(in height: CGFloat) -> CGFloat {
        height - size.height - origin.y
    }
    
    /// Converts rect to constant usable for creating center constraint.
    ///
    ///     let constant: CGFloat = rect.center
    ///
    public var center: CGPoint {
        .init(x: centerX, y: centerY)
    }
    
    /// Converts rect to constant usable for creating center `x` constraint.
    ///
    ///     let constant: CGFloat = rect.centerX
    ///
    public var centerX: CGFloat {
        origin.x + width / 2
    }
    
    /// Converts rect to constant usable for creating center `y` constraint.
    ///
    ///     let constant: CGFloat = rect.centerY
    ///
    public var centerY: CGFloat {
        origin.y + height / 2
    }
}
