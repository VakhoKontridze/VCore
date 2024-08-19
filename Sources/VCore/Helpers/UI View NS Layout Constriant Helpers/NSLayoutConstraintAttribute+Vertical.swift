//
//  NSLayoutConstraintAttribute+Vertical.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - NS Layout Constraint Attribute + Vertical
extension NSLayoutConstraint.Attribute {
    /// Part of the object’s visual vertical representation that should be used to get the value for the constraint.
    public enum Vertical: Int, CaseIterable {
        // MARK: Cases
        /// Top of the object’s alignment rectangle.
        case top
        
        /// Center along the y-axis of the object’s alignment rectangle.
        case centerY
        
        /// Bottom of the object’s alignment rectangle.
        case bottom
        
        /// Object’s baseline. For objects with more than one line of text, this is the baseline for the topmost line of text.
        case firstBaseline
        
        /// Object’s baseline. For objects with more than one line of text, this is the baseline for the bottommost line of text.
        case lastBaseline
        
        // MARK: Mapping
        /// Converts `VerticalAttribute` to `NSLayoutConstraint.Attribute`.
        public var toNSLayoutConstraintAttribute: NSLayoutConstraint.Attribute {
            switch self {
            case .top: .top
            case .centerY: .centerY
            case .bottom: .bottom
            case .firstBaseline: .firstBaseline
            case .lastBaseline: .lastBaseline
            }
        }
    }
}

// MARK: - UI View + Constraints
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
        attribute: NSLayoutConstraint.Attribute.Vertical = .top,
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
            attribute: attribute.toNSLayoutConstraintAttribute,
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
    ///             attribute: .centerY,
    ///             relation: .equal,
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
        attribute: NSLayoutConstraint.Attribute.Vertical = .centerY,
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
            attribute: attribute.toNSLayoutConstraintAttribute,
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
    ///             attribute: .bottom,
    ///             relation: .equal,
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
        attribute: NSLayoutConstraint.Attribute.Vertical = .bottom,
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
            attribute: attribute.toNSLayoutConstraintAttribute,
            multiplier: multiplier,
            constant: constant,
            priority: priority
        )
    }
    
    /// Constraints `UIView`'s `DimensionAttribute.firstBaseline` to another `UIView`'s `VerticalAttribute`,
    /// with given `relation`, `constant`, `multiplier`, and `priority`.
    ///
    /// By default, another `UIView`'s `VerticalAttribute` is set to `firstBaseline`.
    ///
    ///     NSLayoutConstraint.activate([
    ///         view1.constraintFirstBaseline(to: view2),
    ///
    ///         view3.constraintFirstBaseline(
    ///             on: .safeArea,
    ///             to: view4,
    ///             layoutGuide: .safeArea,
    ///             attribute: .firstBaseline,
    ///             relation: .equal,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintFirstBaseline(
        on selfLayoutGuide: UILayoutGuideType? = nil,
        to view: UIView?,
        layoutGuide: UILayoutGuideType? = nil,
        attribute: NSLayoutConstraint.Attribute.Vertical = .firstBaseline,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: selfLayoutGuide?.toLayoutGuide(in: self) ?? self,
            attribute: .firstBaseline,
            relatedBy: relation,
            toItem: view.flatMap { layoutGuide?.toLayoutGuide(in: $0) } ?? view,
            attribute: attribute.toNSLayoutConstraintAttribute,
            multiplier: multiplier,
            constant: constant,
            priority: priority
        )
    }
    
    /// Constraints `UIView`'s `DimensionAttribute.lastBaseline` to another `UIView`'s `VerticalAttribute`,
    /// with given `relation`, `constant`, `multiplier`, and `priority`.
    ///
    /// By default, another `UIView`'s `VerticalAttribute` is set to `lastBaseline`.
    ///
    ///     NSLayoutConstraint.activate([
    ///         view1.constraintLastBaseline(to: view2),
    ///
    ///         view3.constraintLastBaseline(
    ///             on: .safeArea,
    ///             to: view4,
    ///             layoutGuide: .safeArea,
    ///             attribute: .lastBaseline,
    ///             relation: .equal,
    ///             constant: 0,
    ///             multiplier: 1,
    ///             priority: .defaultHigh
    ///         )
    ///     ])
    ///
    public func constraintLastBaseline(
        on selfLayoutGuide: UILayoutGuideType? = nil,
        to view: UIView?,
        layoutGuide: UILayoutGuideType? = nil,
        attribute: NSLayoutConstraint.Attribute.Vertical = .lastBaseline,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint {
        .init(
            item: selfLayoutGuide?.toLayoutGuide(in: self) ?? self,
            attribute: .lastBaseline,
            relatedBy: relation,
            toItem: view.flatMap { layoutGuide?.toLayoutGuide(in: $0) } ?? view,
            attribute: attribute.toNSLayoutConstraintAttribute,
            multiplier: multiplier,
            constant: constant,
            priority: priority
        )
    }
}

#endif
