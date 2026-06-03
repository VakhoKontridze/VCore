//
//  NSLayoutConstraint+WithMultiplier.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/5/21.
//

#if canImport(UIKit)
public import UIKit
#elseif canImport(AppKit)
public import AppKit
#endif

@available(watchOS, unavailable)
extension NSLayoutConstraint {
    /// Modifies and returns multiplier with a given priority.
    ///
    /// Must be called after other `NSLayoutConstraint` modifiers.
    ///
    ///     NSLayoutConstraint.activate([
    ///         view.widthAnchor.constraint(equalTo: otherView.widthAnchor)
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
