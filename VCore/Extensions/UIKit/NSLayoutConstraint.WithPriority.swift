//
//  NSLayoutConstraint.WithPriority.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/13/21.
//

import UIKit

// MARK: - Layout Constraint with Priority
extension NSLayoutConstraint {
    /// Modifies and returns constraint with a given priority.
    ///
    /// Usage Example:
    ///
    ///     NSLayoutConstraint.activate([
    ///         view.widthAnchor.constraint(equalToConstant: 100)
    ///             .withPriority(.defaultHigh)
    ///     ])
    ///
    public func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
    
    /// Modifies and returns constraint with a given priority value.
    ///
    /// Usage Example:
    ///
    ///     NSLayoutConstraint.activate([
    ///         view.widthAnchor.constraint(equalToConstant: 100)
    ///             .withPriority(999)
    ///     ])
    ///
    public func withPriority(_ value: CGFloat) -> NSLayoutConstraint {
        self.priority = .init(.init(value))
        return self
    }
}
