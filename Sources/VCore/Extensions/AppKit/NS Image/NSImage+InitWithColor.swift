//
//  NSImage+InitWithColor.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28.11.23.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import AppKit

// MARK: - NS Image + Init with Color
extension NSImage {
    /// Initializes `UIImage` with `CGSize` and `NSColor`.
    ///
    ///     let image: UIImage = .init(
    ///         size: CGSize(dimension: 100),
    ///         color: NSColor.systemBlue
    ///     )!
    ///
    convenience public init?(
        size: CGSize,
        color: NSColor
    ) {
        self.init(size: size)
        
        lockFocus()
        defer { unlockFocus() }

        color.drawSwatch(
            in: NSRect(
                origin: CGPoint.zero,
                size: size
            )
        )
    }
}

#if DEBUG

import SwiftUI

// MARK: - Preview
#Preview {
    guard
        let image: NSImage = .init(
            size: CGSize(dimension: 100),
            color: NSColor.systemBlue
        )
    else {
        return EmptyView()
    }

    return Image(nsImage: image)
}

#endif

#endif
