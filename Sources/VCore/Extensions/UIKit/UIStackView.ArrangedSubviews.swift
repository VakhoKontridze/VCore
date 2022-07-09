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
    /// Adds `UIView`s as arranged subviews.
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
        views.forEach { addArrangedSubview($0) }
    }
    
    /// Adds `UIView`s as arranged subviews.
    ///
    ///     let stackView: UIStackView = .init()
    ///
    ///     stackView.addArrangedSubviews(
    ///         subview1,
    ///         subview2,
    ///         subview3
    ///     ]
    ///
    public func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
    
    /// Removes all `UIView`s from arranged subviews.
    ///
    ///     stackView.removeArrangedSubviews()
    ///
    public func removeArrangedSubviews() {
        arrangedSubviews.forEach { removeArrangedSubview($0) }
    }
}

#endif
