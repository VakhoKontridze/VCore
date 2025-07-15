//
//  UILayoutGuideType.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Layout Guide Type
/// Model that represents `UILayoutGuide`.
public enum UILayoutGuideType: Sendable {
    // MARK: Cases
    /// Layout guide representing the view’s margins.
    case margins
    
    /// Layout guide representing an area with a readable width within the view.
    case readableContent
    
    /// Layout guide representing the portion of your view that is unobscured by bars and other content.
    case safeArea
    
    /// Layout guide that tracks the keyboard’s position in your app’s layout.
    @available(tvOS, unavailable)
    case keyboard
    
    /// Custom layout guide.
    ///
    /// `KeyPath` cannot be used in declaration, as generic `Value` disallows the use of subclasses,
    /// such as `UITrackingLayoutGuide` and `UIKeyboardLayoutGuide`.
    ///
    ///     extension UIView {
    ///         var someLayoutGuide: UILayoutGuide { ... }
    ///     }
    ///
    ///     extension UILayoutGuideType {
    ///         static var someLayoutGuide: Self { .custom({ $0.someLayoutGuide }) }
    ///     }
    ///
    ///     view.constraintLeading(
    ///         ...
    ///         layoutGuide: .someLayoutGuide,
    ///         ...
    ///     )
    ///
    case custom(@MainActor (UIView) -> UILayoutGuide)
    
    // MARK: Properties
    /// Converts `UILayoutGuideType` to `UILayoutGuide` within the context of a `UIView`.
    @MainActor
    public func toLayoutGuide(in view: UIView) -> UILayoutGuide {
        switch self {
        case .margins:
            return view.layoutMarginsGuide
            
        case .readableContent:
            return view.readableContentGuide
            
        case .safeArea:
            return view.safeAreaLayoutGuide
            
#if !os(tvOS)
        case .keyboard:
            return view.keyboardLayoutGuide
#endif
            
        case .custom(let block):
            return block(view)
        }
    }
}

#endif
