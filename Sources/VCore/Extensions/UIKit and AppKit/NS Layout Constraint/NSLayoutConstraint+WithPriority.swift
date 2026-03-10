//
//  NSLayoutConstraint+WithPriority.swift
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

extension NSLayoutConstraint {
#if canImport(UIKit)
    /// Modifies and returns constraint with a given priority.
    ///
    ///     NSLayoutConstraint.activate([
    ///         view.widthAnchor.constraint(equalToConstant: 100)
    ///             .withPriority(.defaultHigh)
    ///     ])
    ///
    public func withPriority(_ priority: UILayoutPriority?) -> NSLayoutConstraint {
        priority.map { self.priority = $0 }
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
    public func withPriority(_ priority: Priority?) -> NSLayoutConstraint {
        priority.map { self.priority = $0 }
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
    public func withPriority(_ value: CGFloat?) -> NSLayoutConstraint {
#if canImport(UIKit)
        value.map { self.priority = UILayoutPriority(Float($0)) }
#elseif canImport(AppKit)
        value.map { self.priority = Priority(Float($0)) }
#endif
        
        return self
    }
}

#endif
