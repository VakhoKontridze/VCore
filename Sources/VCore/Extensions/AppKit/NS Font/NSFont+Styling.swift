//
//  NSFont+Styling.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.07.22.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import AppKit

extension NSFont {
    /// Returns `NSFont` with italic styling.
    ///
    ///     let systemFont: NSFont = .systemFont(ofSize: 13)
    ///     let italicSystemFont: NSFont? = systemFont.withItalicStyling()
    ///
    public func withItalicStyling() -> NSFont? {
        .init(
            descriptor: fontDescriptor.withSymbolicTraits(.italic),
            size: 0
        )
    }

    /// Returns `NSFont` with bold styling.
    ///
    ///     let systemFont: NSFont = .systemFont(ofSize: 13)
    ///     let boldSystemFont: NSFont? = systemFont.withBoldStyling()
    ///
    public func withBoldStyling() -> NSFont? {
        .init(
            descriptor: fontDescriptor.withSymbolicTraits(.bold),
            size: 0
        )
    }
}

#if DEBUG

import SwiftUI

#Preview {
    let font: NSFont = .systemFont(ofSize: 13)

    VStack {
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
    }
    .padding()
}

#endif

#endif
