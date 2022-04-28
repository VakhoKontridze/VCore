//
//  UIStackView.ArrangedSubviews.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/5/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Arranged Subviews
extension UIStackView {
    /// Adds views as arranged subviews.
    ///
    /// Usage Example:
    ///
    ///     let stackView: UIStackView = .init()
    ///
    ///     stackView.addArrangedSubviews([
    ///         subview1,
    ///         subview2,
    ///         subview3
    ///     ])
    ///
    public func addArrangedSubviews(_ views: [UIView]) {
        arrangedSubviews.forEach { addArrangedSubview($0) }
    }
    
    /// Removes all views from arranged subviews.
    ///
    /// Usage Example:
    ///
    ///     stackView.removeArrangedSubviews()
    ///
    public func removeArrangedSubviews() {
        arrangedSubviews.forEach { removeArrangedSubview($0) }
    }
}

#endif
