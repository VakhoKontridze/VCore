//
//  UILayoutGuideType.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Layout Guide Type
/// ???.
public enum UILayoutGuideType: Int, CaseIterable {
    // MARK: Cases
    /// ???.
    case margins
    
    /// ???.
    case readableContent
    
    /// ???.
    case safeArea
    
    /// ???.
    @available(iOS 15.0, *)
    case keyboard
    
    // MARK: Properties
    public static var allCases: [UILayoutGuideType] {
        if #available(iOS 15.0, *) {
            return [.margins, .readableContent, .safeArea, .keyboard]
        } else {
            return [.margins, .readableContent, .safeArea]
        }
    }
    
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
        }
    }
}

#endif
