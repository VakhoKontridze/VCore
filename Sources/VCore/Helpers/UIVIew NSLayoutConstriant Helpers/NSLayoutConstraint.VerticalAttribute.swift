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
        
        // MARK: Properties
        /// Converts `VerticalAttribute` to `Attribute`.
        public var toAttribute: Attribute {
            switch self {
            case .top: return .top
            case .centerY: return .centerY
            case .bottom: return .bottom
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
    ///             on: .safeArea,
    ///             to: view4,
    ///             layoutGuide: .safeArea,
    ///             attribute: .top,
    ///             relation: .equal,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintTop(
        on selfLayoutGuide: UILayoutGuideType? = nil,
        to view: UIView?,
        layoutGuide: UILayoutGuideType? = nil,
        attribute: NSLayoutConstraint.VerticalAttribute = .top,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: selfLayoutGuide?.toLayoutGuide(in: self) ?? self,
            attribute: .top,
            relatedBy: relation,
            toItem: view.flatMap { layoutGuide?.toLayoutGuide(in: $0) } ?? view,
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
    ///             on: .safeArea,
    ///             to: view4,
    ///             layoutGuide: .safeArea,
    ///             attribute: .top,
    ///             relation: .centerY,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintCenterY(
        on selfLayoutGuide: UILayoutGuideType? = nil,
        to view: UIView?,
        layoutGuide: UILayoutGuideType? = nil,
        attribute: NSLayoutConstraint.VerticalAttribute = .centerY,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: selfLayoutGuide?.toLayoutGuide(in: self) ?? self,
            attribute: .centerY,
            relatedBy: relation,
            toItem: view.flatMap { layoutGuide?.toLayoutGuide(in: $0) } ?? view,
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
    ///             on: .safeArea,
    ///             to: view4,
    ///             layoutGuide: .safeArea,
    ///             attribute: .top,
    ///             relation: .bottom,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintBottom(
        on selfLayoutGuide: UILayoutGuideType? = nil,
        to view: UIView?,
        layoutGuide: UILayoutGuideType? = nil,
        attribute: NSLayoutConstraint.VerticalAttribute = .bottom,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: selfLayoutGuide?.toLayoutGuide(in: self) ?? self,
            attribute: .bottom,
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
