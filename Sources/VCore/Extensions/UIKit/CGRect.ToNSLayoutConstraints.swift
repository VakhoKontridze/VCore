//
//  CGRect.ToNSLayoutConstraints.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - CGRect to NSLayoutConstraints
extension CGRect {
    /// Converts rect to constant usable for creating leading constraint.
    public var leadingConstraintConstant: CGFloat {
        origin.x
    }
    
    /// Converts rect to constant usable for creating trailing constraint.
    public func trailingConstraintConstant(in width: CGFloat) -> CGFloat {
        width - size.width - origin.x
    }
    
    /// Converts rect to constant usable for creating top constraint.
    public var topConstraintConstant: CGFloat {
        origin.y
    }
    
    /// Converts rect to constant usable for creating bottom constraint.
    public func bottomConstraintConstant(in height: CGFloat) -> CGFloat {
        height - size.height - origin.y
    }
    
    /// Converts rect to constant usable for creating center constraint.
    public var center: CGPoint {
        .init(x: centerX, y: centerY)
    }

    /// Converts rect to constant usable for creating center `x` constraint.
    public var centerX: CGFloat {
        origin.x + width / 2
    }

    /// Converts rect to constant usable for creating center `y` constraint.
    public var centerY: CGFloat {
        origin.y + height / 2
    }
}

#endif
