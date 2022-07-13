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
        
        // MARK: Properties
        /// Converts `HorizontalAttribute` to `Attribute`.
        public var toAttribute: Attribute {
            switch self {
            case .leading: return .leading
            case .centerX: return .centerX
            case .trailing: return .trailing
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
        attribute: NSLayoutConstraint.HorizontalAttribute = .leading,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        return .init(
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
        attribute: NSLayoutConstraint.HorizontalAttribute = .centerX,
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
        attribute: NSLayoutConstraint.HorizontalAttribute = .trailing,
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
}

#endif
