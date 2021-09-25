//
//  NSLayoutConstraintPriorities.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/13/21.
//

import UIKit

// MARK: - NS Layout Constraint Priorities
extension NSLayoutConstraint {
    /// Modifies and returns constraint with a given priority
    public func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
    
    /// Modifies and returns constraint with a given priority value
    public func withPriority(_ value: CGFloat) -> NSLayoutConstraint {
        self.priority = .init(.init(value))
        return self
    }
}
