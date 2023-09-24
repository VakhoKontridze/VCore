//
//  NSLayoutConstraint.Attribute.Dimension.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Dimension Attribute
extension NSLayoutConstraint.Attribute {
    /// Part of the object’s visual dimension representation that should be used to get the value for the constraint.
    public enum Dimension: Int, CaseIterable {
        // MARK: Cases
        /// Width of the object’s alignment rectangle.
        case width
        
        /// Height of the object’s alignment rectangle.
        case height
        
        // MARK: Properties
        /// Converts `DimensionAttribute` to `NSLayoutConstraint.Attribute`.
        public var toAttribute: NSLayoutConstraint.Attribute {
            switch self {
            case .width: .width
            case .height: .height
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
    ///             on: .safeArea,
    ///             to: view4,
    ///             layoutGuide: .safeArea,
    ///             attribute: .width,
    ///             relation: .equal,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintWidth(
        on selfLayoutGuide: UILayoutGuideType? = nil,
        to view: UIView?,
        layoutGuide: UILayoutGuideType? = nil,
        attribute: NSLayoutConstraint.Attribute.Dimension = .width,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: selfLayoutGuide?.toLayoutGuide(in: self) ?? self,
            attribute: .width,
            relatedBy: relation,
            toItem: view.flatMap { layoutGuide?.toLayoutGuide(in: $0) } ?? view,
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
    ///             on: .safeArea,
    ///             to: view4,
    ///             layoutGuide: .safeArea,
    ///             attribute: .height,
    ///             relation: .equal,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintHeight(
        on selfLayoutGuide: UILayoutGuideType? = nil,
        to view: UIView?,
        layoutGuide: UILayoutGuideType? = nil,
        attribute: NSLayoutConstraint.Attribute.Dimension = .height,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: selfLayoutGuide?.toLayoutGuide(in: self) ?? self,
            attribute: .height,
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
