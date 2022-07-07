//
//  NSLayoutConstraint.DimensionAttribute.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Dimension Attribute
extension NSLayoutConstraint {
    /// Part of the object’s visual dimension representation that should be used to get the value for the constraint.
    public enum DimensionAttribute: Int, CaseIterable, @unchecked Sendable {
        // MARK: Cases
        /// Width of the object’s alignment rectangle.
        case width
        
        /// Height of the object’s alignment rectangle.
        case height
        
        /// Safe width of the object’s alignment rectangle.
        case safeWidth
        
        /// Safe height of the object’s alignment rectangle.
        case safeHeight
        
        // MARK: Properties
        /// Converts `DimensionAttribute` to `Attribute`.
        public var toAttribute: Attribute {
            switch self {
            case .width, .safeWidth: return .width
            case .height, .safeHeight: return .height
            }
        }
        
        /// Indicates if attribute is constrained to `safeAreaLayoutGuide`.
        public var isSafe: Bool {
            switch self {
            case .width, .height: return false
            case .safeWidth, .safeHeight: return true
            }
        }
    }
}

// MARK: - Constraints
extension UIView {
    /// Constraints `UIView`'s `DimensionAttribute.width` to another `UIView`'s `DimensionAttribute`,
    /// with given `relation`, `constant`, `multiplier`, and `priority`.
    ///
    /// By default, another `UIView`'s `DimensionAttribute` is set to `width`.
    ///
    ///     NSLayoutConstraint.activate([
    ///         view1.constraintWidth(to: view2),
    ///
    ///         view3.constraintWidth(
    ///             to: view4,
    ///             attribute: .width,
    ///             relation: .equal,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintWidth(
        to view: UIView?,
        attribute: NSLayoutConstraint.DimensionAttribute = .width,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: self.layoutItem(isSafe: false),
            attribute: .width,
            relatedBy: relation,
            toItem: view?.layoutItem(isSafe: attribute.isSafe),
            attribute: attribute.toAttribute,
            multiplier: multiplier,
            constant: constant,
            priority: priority
        )
    }
    
    /// Constraints `UIView`'s `DimensionAttribute.height` to another `UIView`'s `DimensionAttribute`,
    /// with given `relation`, `constant`, `multiplier`, and `priority`.
    ///
    /// By default, another `UIView`'s `DimensionAttribute` is set to `height`.
    ///
    ///     NSLayoutConstraint.activate([
    ///         view1.constraintHeight(to: view2),
    ///
    ///         view3.constraintHeight(
    ///             to: view4,
    ///             attribute: .height,
    ///             relation: .equal,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintHeight(
        to view: UIView?,
        attribute: NSLayoutConstraint.DimensionAttribute = .height,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: self.layoutItem(isSafe: false),
            attribute: .height,
            relatedBy: relation,
            toItem: view?.layoutItem(isSafe: attribute.isSafe),
            attribute: attribute.toAttribute,
            multiplier: multiplier,
            constant: constant,
            priority: priority
        )
    }
    
    /// Constraints `UIView`'s `DimensionAttribute.safeWidth` to another `UIView`'s `DimensionAttribute`,
    /// with given `relation`, `constant`, `multiplier`, and `priority`.
    ///
    /// By default, another `UIView`'s `DimensionAttribute` is set to `safeWidth`.
    ///
    ///     NSLayoutConstraint.activate([
    ///         view1.constraintSafeWidth(to: view2),
    ///
    ///         view3.constraintSafeWidth(
    ///             to: view4,
    ///             attribute: .safeWidth,
    ///             relation: .equal,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintSafeWidth(
        to view: UIView?,
        attribute: NSLayoutConstraint.DimensionAttribute = .safeWidth,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: self.layoutItem(isSafe: true),
            attribute: .width,
            relatedBy: relation,
            toItem: view?.layoutItem(isSafe: attribute.isSafe),
            attribute: attribute.toAttribute,
            multiplier: multiplier,
            constant: constant,
            priority: priority
        )
    }
    
    /// Constraints `UIView`'s `DimensionAttribute.safeHeight` to another `UIView`'s `DimensionAttribute`,
    /// with given `relation`, `constant`, `multiplier`, and `priority`.
    ///
    /// By default, another `UIView`'s `DimensionAttribute` is set to `safeHeight`.
    ///
    ///     NSLayoutConstraint.activate([
    ///         view1.constraintSafeHeight(to: view2),
    ///
    ///         view3.constraintSafeHeight(
    ///             to: view4,
    ///             attribute: .safeHeight,
    ///             relation: .equal,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintSafeHeight(
        to view: UIView?,
        attribute: NSLayoutConstraint.DimensionAttribute = .safeHeight,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: self.layoutItem(isSafe: true),
            attribute: .height,
            relatedBy: relation,
            toItem: view?.layoutItem(isSafe: attribute.isSafe),
            attribute: attribute.toAttribute,
            multiplier: multiplier,
            constant: constant,
            priority: priority
        )
    }
}

#endif
