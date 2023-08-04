//
//  NSLayoutConstraint.Storing.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/13/21.
//

#if !os(watchOS)

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// MARK: - Layout Constraint Storing
extension NSLayoutConstraint {
    /// Allows for the storing of a layout constraint, while using it in `NSLayoutConstraint.activate(:_)`.
    ///
    ///     var tableViewLeadingConstraint: NSLayoutConstraint!
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
