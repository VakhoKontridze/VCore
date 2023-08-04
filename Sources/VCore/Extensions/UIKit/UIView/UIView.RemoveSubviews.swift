//
//  UIView.RemoveSubviews.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 09.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - View Add Subviews
extension UIView {
    /// Removes all `UIView`s from superview.
    ///
    ///     view.removeSubviewsFromSuperview()
    ///
    public func removeSubviewsFromSuperview() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}

#endif
