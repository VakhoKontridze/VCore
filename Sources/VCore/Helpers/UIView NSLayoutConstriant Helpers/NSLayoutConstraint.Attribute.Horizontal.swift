//
//  NSLayoutConstraint.Attribute.Horizontal.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Horizontal Attribute
extension NSLayoutConstraint.Attribute {
    /// Part of the object’s visual horizontal representation that should be used to get the value for the constraint.
    public enum Horizontal: Int, CaseIterable {
        // MARK: Cases
        /// Leading edge of the object’s alignment rectangle.
        case leading
        
        /// Center along the x-axis of the object’s alignment rectangle.
        case centerX
        
        /// Trailing edge of the object’s alignment rectangle.
        case trailing
        
        /// Left side of the object’s alignment rectangle.
        case left
        
        /// Right side of the object’s alignment rectangle.
        case right
        
        // MARK: Properties
        /// Converts `HorizontalAttribute` to `NSLayoutConstraint.Attribute`.
        public var toAttribute: NSLayoutConstraint.Attribute {
            switch self {
            case .leading: return .leading
            case .centerX: return .centerX
            case .trailing: return .trailing
            case .left: return .left
            case .right: return .right
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
    ///             on: .safeArea,
    ///             to: view4,
    ///             layoutGuide: .safeArea,
    ///             attribute: .leading,
    ///             relation: .equal,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintLeading(
        on selfLayoutGuide: UILayoutGuideType? = nil,
        to view: UIView?,
        layoutGuide: UILayoutGuideType? = nil,
        attribute: NSLayoutConstraint.Attribute.Horizontal = .leading,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: selfLayoutGuide?.toLayoutGuide(in: self) ?? self,
            attribute: .leading,
            relatedBy: relation,
            toItem: view.flatMap { layoutGuide?.toLayoutGuide(in: $0) } ?? view,
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
    ///             on: .safeArea,
    ///             to: view4,
    ///             layoutGuide: .safeArea,
    ///             attribute: .centerX,
    ///             relation: .equal,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintCenterX(
        on selfLayoutGuide: UILayoutGuideType? = nil,
        to view: UIView?,
        layoutGuide: UILayoutGuideType? = nil,
        attribute: NSLayoutConstraint.Attribute.Horizontal = .centerX,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: selfLayoutGuide?.toLayoutGuide(in: self) ?? self,
            attribute: .centerX,
            relatedBy: relation,
            toItem: view.flatMap { layoutGuide?.toLayoutGuide(in: $0) } ?? view,
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
    ///             on: .safeArea,
    ///             to: view4,
    ///             layoutGuide: .safeArea,
    ///             attribute: .trailing,
    ///             relation: .equal,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintTrailing(
        on selfLayoutGuide: UILayoutGuideType? = nil,
        to view: UIView?,
        layoutGuide: UILayoutGuideType? = nil,
        attribute: NSLayoutConstraint.Attribute.Horizontal = .trailing,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: selfLayoutGuide?.toLayoutGuide(in: self) ?? self,
            attribute: .trailing,
            relatedBy: relation,
            toItem: view.flatMap { layoutGuide?.toLayoutGuide(in: $0) } ?? view,
            attribute: attribute.toAttribute,
            multiplier: multiplier,
            constant: constant,
            priority: priority
        )
    }
    
    /// Constraints `UIView`'s `DimensionAttribute.left` to another `UIView`'s `HorizontalAttribute`,
    /// with given `relation`, `constant`, `multiplier`, and `priority`.
    ///
    /// By default, another `UIView`'s `HorizontalAttribute` is set to `left`.
    ///
    ///     NSLayoutConstraint.activate([
    ///         view1.constraintLeft(to: view2),
    ///
    ///         view3.constraintLeft(
    ///             on: .safeArea,
    ///             to: view4,
    ///             layoutGuide: .safeArea,
    ///             attribute: .left,
    ///             relation: .equal,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintLeft(
        on selfLayoutGuide: UILayoutGuideType? = nil,
        to view: UIView?,
        layoutGuide: UILayoutGuideType? = nil,
        attribute: NSLayoutConstraint.Attribute.Horizontal = .left,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: selfLayoutGuide?.toLayoutGuide(in: self) ?? self,
            attribute: .left,
            relatedBy: relation,
            toItem: view.flatMap { layoutGuide?.toLayoutGuide(in: $0) } ?? view,
            attribute: attribute.toAttribute,
            multiplier: multiplier,
            constant: constant,
            priority: priority
        )
    }
    
    /// Constraints `UIView`'s `DimensionAttribute.right` to another `UIView`'s `HorizontalAttribute`,
    /// with given `relation`, `constant`, `multiplier`, and `priority`.
    ///
    /// By default, another `UIView`'s `HorizontalAttribute` is set to `right`.
    ///
    ///     NSLayoutConstraint.activate([
    ///         view1.constraintRight(to: view2),
    ///
    ///         view3.constraintRight(
    ///             on: .safeArea,
    ///             to: view4,
    ///             layoutGuide: .safeArea,
    ///             attribute: .right,
    ///             relation: .equal,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintRight(
        on selfLayoutGuide: UILayoutGuideType? = nil,
        to view: UIView?,
        layoutGuide: UILayoutGuideType? = nil,
        attribute: NSLayoutConstraint.Attribute.Horizontal = .right,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: selfLayoutGuide?.toLayoutGuide(in: self) ?? self,
            attribute: .right,
            relatedBy: relation,
            toItem: view.flatMap { layoutGuide?.toLayoutGuide(in: $0) } ?? view,
            attribute: attribute.toAttribute,
            multiplier: multiplier,
            constant: constant,
            priority: priority
        )
    }
}

#endif
