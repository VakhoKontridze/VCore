//
//  UIFont.Styling.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/5/21.
//

import UIKit

// MARK: - Font Styling
extension UIFont {
    /// Returns font with bold styling.
    ///
    /// Usage Example:
    ///
    ///     let systemFont: UIFont? = .systemFont(ofSize: 13)
    ///     let boldSystemFont: UIFont? = systemFont.withBoldStyling
    ///
    public var withBoldStyling: UIFont? {
        fontDescriptor.withSymbolicTraits(.traitBold).map { .init(descriptor: $0, size: 0) }
    }
    
    /// Returns font with italic styling.
    ///
    /// Usage Example:
    ///
    ///     let systemFont: UIFont? = .systemFont(ofSize: 13)
    ///     let italicSystemFont: UIFont? = systemFont.withItalicStyling
    ///
    public var withItalicStyling: UIFont? {
        fontDescriptor.withSymbolicTraits(.traitItalic).map { .init(descriptor: $0, size: 0) }
    }
}
