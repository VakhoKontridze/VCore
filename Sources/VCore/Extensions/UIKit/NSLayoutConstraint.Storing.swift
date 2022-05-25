//
//  NSLayoutConstraint.Storing.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/13/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Storing Layout Constraint
extension NSLayoutConstraint {
    /// Allows for the storing of a layout constraint, while using it in `NSLayoutConstraint.activate(:_)`.
    ///
    ///     NSLayoutConstraint.activate([
    ///         tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
    ///             .storing(in: &tableViewLeadingConstraint)
    ///     ])
    ///
    public func storing(in container: inout NSLayoutConstraint?) -> NSLayoutConstraint {
        container = self
        return self
    }
}

#endif
