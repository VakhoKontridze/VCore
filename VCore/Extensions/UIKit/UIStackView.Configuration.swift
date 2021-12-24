//
//  UIStackView.Configuration.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/5/21.
//

import UIKit

// MARK: - Stack View Configuration
extension UIStackView {
    /// Configures`UIStackView` with axis, distribution, alignment, and spacing.
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
    public convenience init(
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
