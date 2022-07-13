//
//  UILayoutGuideType.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Layout Guide Type
/// Enumeration that represents `UILayoutGuide`.
public enum UILayoutGuideType {
    // MARK: Cases
    /// Layout guide representing the view’s margins.
    case margins
    
    /// Layout guide representing an area with a readable width within the view.
    case readableContent
    
    /// Layout guide representing the portion of your view that is unobscured by bars and other content.
    case safeArea
    
    /// Layout guide that tracks the keyboard’s position in your app’s layout.
    @available(iOS 15.0, *)
    case keyboard
    
    /// Custom layout guide.
    ///
    ///     extension UIView {
    ///         var someOtherLayoutGuide: UILayoutGuide { ... }
    ///     }
    ///
    ///     extension UILayoutGuideType {
    ///         static var someOther: Self { .custom(\.someLayoutGuide) }
    ///     }
    ///
    ///     view.constraintLeading(
    ///         ...
    ///         layoutGuide: .someOther,
    ///         ...
    ///     )
    ///
    case custom(KeyPath<UIView, UILayoutGuide>)
    
    // MARK: Properties
    /// Converts `UILayoutGuideType` to `UILayoutGuide` within the context of an `UIView`.
    public func toLayoutGuide(in view: UIView) -> UILayoutGuide {
        switch self {
        case .margins:
            return view.layoutMarginsGuide
        
        case .readableContent:
            return view.readableContentGuide
        
        case .safeArea:
            return view.safeAreaLayoutGuide
        
        case .keyboard:
            if #available(iOS 15.0, *) {
                return view.keyboardLayoutGuide
            } else {
                fatalError()
            }
            
        case .custom(let layoutGuideKeyPath):
            return view[keyPath: layoutGuideKeyPath]
        }
    }
}

#endif
