//
//  NSLayoutConstraint.VerticalAttribute.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Vertical Attribute
extension NSLayoutConstraint {
    /// Part of the object’s visual vertical representation that should be used to get the value for the constraint.
    public enum VerticalAttribute: Int, CaseIterable, @unchecked Sendable {
        // MARK: Cases
        /// Top of the object’s alignment rectangle.
        case top
        
        /// Center along the y-axis of the object’s alignment rectangle.
        case centerY
        
        /// Bottom of the object’s alignment rectangle.
        case bottom
        
        /// Safe top of the object’s alignment rectangle.
        case safeTop
        
        /// Safe center along the y-axis of the object’s alignment rectangle.
        case safeCenterY
        
        /// Safe bottom of the object’s alignment rectangle.
        case safeBottom
        
        // MARK: Properties
        /// Converts `VerticalAttribute` to `Attribute`.
        public var toAttribute: Attribute {
            switch self {
            case .top, .safeTop: return .top
            case .centerY, .safeCenterY: return .centerY
            case .bottom, .safeBottom: return .bottom
            }
        }
        
        /// Indicates if attribute is constrained to `safeAreaLayoutGuide`.
        public var isSafe: Bool {
            switch self {
            case .top, .centerY, .bottom: return false
            case .safeTop, .safeCenterY, .safeBottom: return true
            }
        }
    }
}

// MARK: - Constraints
extension UIView {
    /// Constraints `UIView`'s `DimensionAttribute.top` to another `UIView`'s `VerticalAttribute`,
    /// with given `relation`, `constant`, `multiplier`, and `priority`.
    ///
    /// By default, another `UIView`'s `VerticalAttribute` is set to `top`.
    ///
    ///     NSLayoutConstraint.activate([
    ///         view1.constraintTop(to: view2),
    ///
    ///         view3.constraintTop(
    ///             to: view4,
    ///             attribute: .top,
    ///             relation: .equal,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintTop(
        to view: UIView,
        attribute: NSLayoutConstraint.VerticalAttribute = .top,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: self.layoutItem(isSafe: false),
            attribute: .top,
            relatedBy: relation,
            toItem: view.layoutItem(isSafe: attribute.isSafe),
            attribute: attribute.toAttribute,
            multiplier: multiplier,
            constant: constant,
            priority: priority
        )
    }
    
    /// Constraints `UIView`'s `DimensionAttribute.centerY` to another `UIView`'s `VerticalAttribute`,
    /// with given `relation`, `constant`, `multiplier`, and `priority`.
    ///
    /// By default, another `UIView`'s `VerticalAttribute` is set to `centerY`.
    ///
    ///     NSLayoutConstraint.activate([
    ///         view1.constraintCenterY(to: view2),
    ///
    ///         view3.constraintCenterY(
    ///             to: view4,
    ///             attribute: .top,
    ///             relation: .centerY,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintCenterY(
        to view: UIView,
        attribute: NSLayoutConstraint.VerticalAttribute = .centerY,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: self.layoutItem(isSafe: false),
            attribute: .centerY,
            relatedBy: relation,
            toItem: view.layoutItem(isSafe: attribute.isSafe),
            attribute: attribute.toAttribute,
            multiplier: multiplier,
            constant: constant,
            priority: priority
        )
    }
    
    /// Constraints `UIView`'s `DimensionAttribute.bottom` to another `UIView`'s `VerticalAttribute`,
    /// with given `relation`, `constant`, `multiplier`, and `priority`.
    ///
    /// By default, another `UIView`'s `VerticalAttribute` is set to `bottom`.
    ///
    ///     NSLayoutConstraint.activate([
    ///         view1.constraintBottom(to: view2),
    ///
    ///         view3.constraintBottom(
    ///             to: view4,
    ///             attribute: .top,
    ///             relation: .bottom,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintBottom(
        to view: UIView,
        attribute: NSLayoutConstraint.VerticalAttribute = .bottom,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: self.layoutItem(isSafe: false),
            attribute: .bottom,
            relatedBy: relation,
            toItem: view.layoutItem(isSafe: attribute.isSafe),
            attribute: attribute.toAttribute,
            multiplier: multiplier,
            constant: constant,
            priority: priority
        )
    }
    
    /// Constraints `UIView`'s `DimensionAttribute.safeTop` to another `UIView`'s `VerticalAttribute`,
    /// with given `relation`, `constant`, `multiplier`, and `priority`.
    ///
    /// By default, another `UIView`'s `VerticalAttribute` is set to `safeTop`.
    ///
    ///     NSLayoutConstraint.activate([
    ///         view1.constraintSafeTop(to: view2),
    ///
    ///         view3.constraintSafeTop(
    ///             to: view4,
    ///             attribute: .top,
    ///             relation: .safeTop,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintSafeTop(
        to view: UIView,
        attribute: NSLayoutConstraint.VerticalAttribute = .safeTop,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: self.layoutItem(isSafe: true),
            attribute: .top,
            relatedBy: relation,
            toItem: view.layoutItem(isSafe: attribute.isSafe),
            attribute: attribute.toAttribute,
            multiplier: multiplier,
            constant: constant,
            priority: priority
        )
    }

    /// Constraints `UIView`'s `DimensionAttribute.safeCenterY` to another `UIView`'s `VerticalAttribute`,
    /// with given `relation`, `constant`, `multiplier`, and `priority`.
    ///
    /// By default, another `UIView`'s `VerticalAttribute` is set to `safeCenterY`.
    ///
    ///     NSLayoutConstraint.activate([
    ///         view1.constraintSafeCenterY(to: view2),
    ///
    ///         view3.constraintSafeCenterY(
    ///             to: view4,
    ///             attribute: .top,
    ///             relation: .safeCenterY,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintSafeCenterY(
        to view: UIView,
        attribute: NSLayoutConstraint.VerticalAttribute = .safeCenterY,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: self.layoutItem(isSafe: true),
            attribute: .centerY,
            relatedBy: relation,
            toItem: view.layoutItem(isSafe: attribute.isSafe),
            attribute: attribute.toAttribute,
            multiplier: multiplier,
            constant: constant,
            priority: priority
        )
    }

    /// Constraints `UIView`'s `DimensionAttribute.safeBottom` to another `UIView`'s `VerticalAttribute`,
    /// with given `relation`, `constant`, `multiplier`, and `priority`.
    ///
    /// By default, another `UIView`'s `VerticalAttribute` is set to `safeBottom`.
    ///
    ///     NSLayoutConstraint.activate([
    ///         view1.constraintSafeBottom(to: view2),
    ///
    ///         view3.constraintSafeBottom(
    ///             to: view4,
    ///             attribute: .top,
    ///             relation: .safeBottom,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintSafeBottom(
        to view: UIView,
        attribute: NSLayoutConstraint.VerticalAttribute = .safeBottom,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: self.layoutItem(isSafe: true),
            attribute: .bottom,
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
