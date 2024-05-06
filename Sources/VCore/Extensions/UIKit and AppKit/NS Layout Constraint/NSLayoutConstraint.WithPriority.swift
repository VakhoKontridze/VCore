//
//  NSLayoutConstraint.WithPriority.swift
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

// MARK: - NS Layout Constraint with Priority
extension NSLayoutConstraint {
#if canImport(UIKit)
    /// Modifies and returns constraint with a given priority.
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
#endif
    
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
    /// Modifies and returns constraint with a given priority.
    ///
    ///     NSLayoutConstraint.activate([
    ///         view.widthAnchor.constraint(equalToConstant: 100)
    ///             .withPriority(.defaultHigh)
    ///     ])
    ///
    public func withPriority(_ priority: Priority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
#endif
    
    /// Modifies and returns constraint with a given priority value.
    ///
    ///     NSLayoutConstraint.activate([
    ///         view.widthAnchor.constraint(equalToConstant: 100)
    ///             .withPriority(500)
    ///     ])
    ///
    public func withPriority(_ value: CGFloat) -> NSLayoutConstraint {
#if canImport(UIKit)
        self.priority = UILayoutPriority(Float(value))
#elseif canImport(AppKit)
        self.priority = Priority(Float(value))
#endif
        
        return self
    }
}

#endif
