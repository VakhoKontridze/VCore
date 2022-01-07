//
//  NSLayoutConstraint.WithMultiplier.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/5/21.
//

import UIKit

// MARK: - Layout Constraint with Multiplier
extension NSLayoutConstraint {
    /// Modifies and returns constraint with a given priority.
    ///
    /// Must be called after other `NSLayoutConstraint` modifiers.
    ///
    /// Usage Example:
    ///
    ///     NSLayoutConstraint.activate([
    ///         view.widthAnchor.constraint(equalTo: someOtherView.widthAnchor)
    ///             .withMultiplier(0.5)
    ///     ])
    ///
    public func withMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        .init(
            item: firstItem as Any,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant
        )
    }
}
