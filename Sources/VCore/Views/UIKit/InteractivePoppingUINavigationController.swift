//
//  InteractivePoppingUINavigationController.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Interactive Popping UI Navigation Controller
/// `UINavigationController` that conforms to `UIGestureRecognizerDelegate` via `interactivePopGestureRecognizer`,
/// and handles interactive popping.
@available(tvOS, unavailable)
open class InteractivePoppingUINavigationController: UINavigationController, Sendable, UIGestureRecognizerDelegate {
    // MARK: Lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        interactivePopGestureRecognizer?.delegate = self
    }
    
    // MARK: Gesture Recognizer Delegate
    open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        viewControllers.count > 1
    }
}

#endif
