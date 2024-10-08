//
//  UIStackView+Configure.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/5/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Stack View + Configure
extension UIStackView {
    /// Configures`UIStackView` with axis, distribution, alignment, and spacing.
    ///
    ///     let stackView: UIStackView = .init()
    ///
    ///     stackView.configure(
    ///         axis: .vertical,
    ///         distribution: .equalSpacing,
    ///         alignment: .leading,
    ///         spacing: 10
    ///     )
    ///
    public func configure(
        axis: NSLayoutConstraint.Axis,
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        spacing: CGFloat = 0
    ) {
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }
    
    /// Initializes `UIStackView` with arranged subviews, axis, distribution, alignment, and spacing.
    ///
    ///     let stackView: UIStackView = .init(
    ///         arrangedSubviews: [
    ///            subview1,
    ///            subview2,
    ///            subview3
    ///         ],
    ///         axis: .vertical,
    ///         distribution: .equalSpacing,
    ///         alignment: .leading,
    ///         spacing: 10
    ///     )
    ///
    convenience public init(
        arrangedSubviews: [UIView] = [],
        axis: NSLayoutConstraint.Axis,
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        spacing: CGFloat = 0
    ) {
        self.init(arrangedSubviews: arrangedSubviews)
        
        configure(
            axis: axis,
            distribution: distribution,
            alignment: alignment,
            spacing: spacing
        )
    }
}

#endif
