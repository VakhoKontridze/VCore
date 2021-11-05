//
//  UIStackView.ArrangedSubviews.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/5/21.
//

import UIKit

// MARK: - Arranged Subviews
extension UIStackView {
    /// Adds views as arranged subviews.
    public func addArrangedSubviews(_ views: [UIView]) {
        arrangedSubviews.forEach { addArrangedSubview($0) }
    }
    
    /// Removes all views from arranged subviews.
    public func removeArrangedSubviews() {
        arrangedSubviews.forEach { removeArrangedSubview($0) }
    }
}
