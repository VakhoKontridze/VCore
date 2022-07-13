//
//  InteractivePoppingUINavigationController.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Interactive Popping UI Navigation Controller
/// `UINavigationController` that conforms to `interactivePopGestureRecognizer` delegate,
/// and handles interactive popping.
open class InteractivePoppingUINavigationController: UINavigationController, UIGestureRecognizerDelegate {
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
