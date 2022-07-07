//
//  NSLayoutConstraint.HorizontalAttribute.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Horizontal Attribute
extension NSLayoutConstraint {
    /// Part of the object’s visual horizontal representation that should be used to get the value for the constraint.
    public enum HorizontalAttribute: Int, CaseIterable, @unchecked Sendable {
        // MARK: Cases
        /// Leading edge of the object’s alignment rectangle.
        case leading
        
        /// Center along the x-axis of the object’s alignment rectangle.
        case centerX
        
        /// Trailing edge of the object’s alignment rectangle.
        case trailing
        
        /// Safe leading edge of the object’s alignment rectangle.
        case safeLeading
        
        /// Safe center along the x-axis of the object’s alignment rectangle.
        case safeCenterX
        
        /// Safe trailing edge of the object’s alignment rectangle.
        case safeTrailing
        
        // MARK: Properties
        /// Converts `HorizontalAttribute` to `Attribute`.
        public var toAttribute: Attribute {
            switch self {
            case .leading, .safeLeading: return .leading
            case .centerX, .safeCenterX: return .centerX
            case .trailing, .safeTrailing: return .trailing
            }
        }
        
        /// Indicates if attribute is constrained to `safeAreaLayoutGuide`.
        public var isSafe: Bool {
            switch self {
            case .leading, .centerX, .trailing: return false
            case .safeLeading, .safeCenterX, .safeTrailing: return true
            }
        }
    }
}

// MARK: - Constraints
extension UIView {
    /// Constraints `UIView`'s `DimensionAttribute.leading` to another `UIView`'s `HorizontalAttribute`,
    /// with given `relation`, `constant`, `multiplier`, and `priority`.
    ///
    /// By default, another `UIView`'s `HorizontalAttribute` is set to `leading`.
    ///
    ///     NSLayoutConstraint.activate([
    ///         view1.constraintLeading(to: view2),
    ///
    ///         view3.constraintLeading(
    ///             to: view4,
    ///             attribute: .leading,
    ///             relation: .equal,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintLeading(
        to view: UIView,
        attribute: NSLayoutConstraint.HorizontalAttribute = .leading,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: self.layoutItem(isSafe: false),
            attribute: .leading,
            relatedBy: relation,
            toItem: view.layoutItem(isSafe: attribute.isSafe),
            attribute: attribute.toAttribute,
            multiplier: multiplier,
            constant: constant,
            priority: priority
        )
    }
    
    /// Constraints `UIView`'s `DimensionAttribute.centerX` to another `UIView`'s `HorizontalAttribute`,
    /// with given `relation`, `constant`, `multiplier`, and `priority`.
    ///
    /// By default, another `UIView`'s `HorizontalAttribute` is set to `centerX`.
    ///
    ///     NSLayoutConstraint.activate([
    ///         view1.constraintCenterX(to: view2),
    ///
    ///         view3.constraintCenterX(
    ///             to: view4,
    ///             attribute: .centerX,
    ///             relation: .equal,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintCenterX(
        to view: UIView,
        attribute: NSLayoutConstraint.HorizontalAttribute = .centerX,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: self.layoutItem(isSafe: false),
            attribute: .centerX,
            relatedBy: relation,
            toItem: view.layoutItem(isSafe: attribute.isSafe),
            attribute: attribute.toAttribute,
            multiplier: multiplier,
            constant: constant,
            priority: priority
        )
    }
    
    /// Constraints `UIView`'s `DimensionAttribute.trailing` to another `UIView`'s `HorizontalAttribute`,
    /// with given `relation`, `constant`, `multiplier`, and `priority`.
    ///
    /// By default, another `UIView`'s `HorizontalAttribute` is set to `trailing`.
    ///
    ///     NSLayoutConstraint.activate([
    ///         view1.constraintTrailing(to: view2),
    ///
    ///         view3.constraintTrailing(
    ///             to: view4,
    ///             attribute: .trailing,
    ///             relation: .equal,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintTrailing(
        to view: UIView,
        attribute: NSLayoutConstraint.HorizontalAttribute = .trailing,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: self.layoutItem(isSafe: false),
            attribute: .trailing,
            relatedBy: relation,
            toItem: view.layoutItem(isSafe: attribute.isSafe),
            attribute: attribute.toAttribute,
            multiplier: multiplier,
            constant: constant,
            priority: priority
        )
    }
    
    /// Constraints `UIView`'s `DimensionAttribute.safeLeading` to another `UIView`'s `HorizontalAttribute`,
    /// with given `relation`, `constant`, `multiplier`, and `priority`.
    ///
    /// By default, another `UIView`'s `HorizontalAttribute` is set to `safeLeading`.
    ///
    ///     NSLayoutConstraint.activate([
    ///         view1.constraintSafeLeading(to: view2),
    ///
    ///         view3.constraintSafeLeading(
    ///             to: view4,
    ///             attribute: .safeLeading,
    ///             relation: .equal,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintSafeLeading(
        to view: UIView,
        attribute: NSLayoutConstraint.HorizontalAttribute = .safeLeading,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: self.layoutItem(isSafe: true),
            attribute: .leading,
            relatedBy: relation,
            toItem: view.layoutItem(isSafe: attribute.isSafe),
            attribute: attribute.toAttribute,
            multiplier: multiplier,
            constant: constant,
            priority: priority
        )
    }
    
    /// Constraints `UIView`'s `DimensionAttribute.safeCenterX` to another `UIView`'s `HorizontalAttribute`,
    /// with given `relation`, `constant`, `multiplier`, and `priority`.
    ///
    /// By default, another `UIView`'s `HorizontalAttribute` is set to `safeCenterX`.
    ///
    ///     NSLayoutConstraint.activate([
    ///         view1.constraintSafeCenterX(to: view2),
    ///
    ///         view3.constraintSafeCenterX(
    ///             to: view4,
    ///             attribute: .safeCenterX,
    ///             relation: .equal,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintSafeCenterX(
        to view: UIView,
        attribute: NSLayoutConstraint.HorizontalAttribute = .safeCenterX,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: self.layoutItem(isSafe: true),
            attribute: .centerX,
            relatedBy: relation,
            toItem: view.layoutItem(isSafe: attribute.isSafe),
            attribute: attribute.toAttribute,
            multiplier: multiplier,
            constant: constant,
            priority: priority
        )
    }
    
    /// Constraints `UIView`'s `DimensionAttribute.safeTrailing` to another `UIView`'s `HorizontalAttribute`,
    /// with given `relation`, `constant`, `multiplier`, and `priority`.
    ///
    /// By default, another `UIView`'s `HorizontalAttribute` is set to `safeTrailing`.
    ///
    ///     NSLayoutConstraint.activate([
    ///         view1.constraintSafeTrailing(to: view2),
    ///
    ///         view3.constraintSafeTrailing(
    ///             to: view4,
    ///             attribute: .safeTrailing,
    ///             relation: .equal,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintSafeTrailing(
        to view: UIView,
        attribute: NSLayoutConstraint.HorizontalAttribute = .safeTrailing,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: self.layoutItem(isSafe: true),
            attribute: .trailing,
            relatedBy: relation,
            toItem: view.layoutItem(isSafe: attribute.isSafe),
            attribute: attribute.toAttribute,
            multiplier: multiplier,
            constant: constant,
            priority: priority
        )
    }
}

#endif
