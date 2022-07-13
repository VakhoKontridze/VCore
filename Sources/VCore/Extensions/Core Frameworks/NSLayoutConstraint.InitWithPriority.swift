//
//  NSLayoutConstraintConstraintMethodHelpers.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.07.22.
//

#if !os(watchOS)

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// MARK: - NS Layout Constraint Init with Priority
extension NSLayoutConstraint {
    /// Initializes `NSLayoutConstraint` with all parameters, plus `UILayoutPriority`.
    ///
    ///     let constraint: NSLayoutConstraint = .init(
    ///         item: view1,
    ///         attribute: .width,
    ///         relatedBy: .equal,
    ///         toItem: view2,
    ///         attribute: .width,
    ///         multiplier: 1,
    ///         constant: 0,
    ///         priority: .required
    ///     )
    ///
    convenience public init(
        item view1: Any,
        attribute attribute1: Attribute,
        relatedBy relation: Relation,
        toItem view2: Any?,
        attribute attribute2: Attribute,
        multiplier: CGFloat,
        constant: CGFloat,
        priority: UILayoutPriority?
    ) {
        self.init(
            item: view1,
            attribute: attribute1,
            relatedBy: relation,
            toItem: view2,
            attribute: attribute2,
            multiplier: multiplier,
            constant: constant
        )
        
        if let priority = priority { self.priority = priority }
    }
}

#endif
