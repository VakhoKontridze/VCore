//
//  NSFont+Styling.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.07.22.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import AppKit

// MARK: - NS Font + Styling
extension NSFont {
    /// Returns `NSFont` with italic styling.
    ///
    ///     let systemFont: UIFont = .systemFont(ofSize: 13)
    ///     let italicSystemFont: UIFont? = systemFont.withItalicStyling()
    ///
    public func withItalicStyling() -> NSFont? {
        .init(descriptor: fontDescriptor.withSymbolicTraits(.italic), size: 0)
    }

    /// Returns `NSFont` with bold styling.
    ///
    ///     let systemFont: UIFont = .systemFont(ofSize: 13)
    ///     let boldSystemFont: UIFont? = systemFont.withBoldStyling()
    ///
    public func withBoldStyling() -> NSFont? {
        .init(descriptor: fontDescriptor.withSymbolicTraits(.bold), size: 0)
    }
}

// MARK: - Preview
#if DEBUG

import SwiftUI

#Preview(body: {
    let font: NSFont = .systemFont(ofSize: 13)

    VStack(content: {
        Text("Lorem ipsum")
            .font(Font(font))

        if let font = font.withItalicStyling() {
            Text("Lorem ipsum")
                .font(Font(font))
        }

        if let font = font.withBoldStyling() {
            Text("Lorem ipsum")
                .font(Font(font))
        }
    })
    .padding()
})

#endif

#endif
