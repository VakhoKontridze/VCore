//
//  UIStackView.RemoveArrangedSubviews.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/5/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Stack View Add Arranged Subviews
extension UIStackView {
    /// Removes all `UIView`s from arranged subviews, but keeps as subviews.
    ///
    ///     stackView.removeArrangedSubviews()
    ///
    public func removeArrangedSubviews() {
        arrangedSubviews.forEach { removeArrangedSubview($0) }
    }
    
    /// Removes all `UIView`s from arranged subviews and from superview.
    ///
    ///     stackView.removeArrangedSubviewsFromSuperview()
    ///
    public func removeArrangedSubviewsFromSuperview() {
        arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}

#endif
