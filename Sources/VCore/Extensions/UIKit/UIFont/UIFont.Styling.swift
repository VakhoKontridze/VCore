//
//  UIFont.Styling.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/5/21.
//

#if canImport(UIKit)

import UIKit

// MARK: - Font Styling
extension UIFont {
    /// Returns `UIFont` with bold styling.
    ///
    ///     let systemFont: UIFont = .systemFont(ofSize: 13)
    ///     let boldSystemFont: UIFont? = systemFont.withBoldStyling
    ///
    public var withBoldStyling: UIFont? {
        fontDescriptor.withSymbolicTraits(.traitBold).map { UIFont(descriptor: $0, size: 0) }
    }
    
    /// Returns `UIFont` with italic styling.
    ///
    ///     let systemFont: UIFont = .systemFont(ofSize: 13)
    ///     let italicSystemFont: UIFont? = systemFont.withItalicStyling
    ///
    public var withItalicStyling: UIFont? {
        fontDescriptor.withSymbolicTraits(.traitItalic).map { UIFont(descriptor: $0, size: 0) }
    }
}

// MARK: - Preview
#if DEBUG

import SwiftUI

#Preview(body: {
    let font: UIFont = .systemFont(ofSize: 16)

    return VStack(content: {
        Text("Lorem ipsum")
            .font(Font(font))

        if let font = font.withBoldStyling {
            Text("Lorem ipsum")
                .font(Font(font))
        }

        if let font = font.withItalicStyling {
            Text("Lorem ipsum")
                .font(Font(font))
        }
    })
    .padding()
})

#endif

#endif
