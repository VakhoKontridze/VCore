//
//  UIView.AddSubviews.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 09.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - View Add Subviews
extension UIView {
    /// Adds `UIView`s as arranged subviews.
    ///
    ///     let view: UIView = .init()
    ///
    ///     view.addSubviews([
    ///         subview1,
    ///         subview2,
    ///         subview3
    ///     ])
    ///
    public func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
    
    /// Adds `UIView`s as arranged subviews.
    ///
    ///     let view: UIView = .init()
    ///
    ///     view.addSubviews(
    ///         subview1,
    ///         subview2,
    ///         subview3
    ///     ]
    ///
    public func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    /// Removes all `UIView`s from arranged subviews.
    ///
    ///     view.removeSubviews()
    ///
    public func removeSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}

#endif
