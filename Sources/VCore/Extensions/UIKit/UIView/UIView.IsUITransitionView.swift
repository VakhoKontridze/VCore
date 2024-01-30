//
//  UIView.IsUITransitionView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28.01.24.
//

#if canImport(UIKit)

import UIKit

// MARK: - Helpers
extension UIView {
    /// ???.
    @available(watchOS, unavailable)
    public var isUITransitionView: Bool {
        String(describing: type(of: self)) == "UITransitionView"
    }
}

#endif
