//
//  NSImage+InitWithColor.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28.11.23.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import AppKit

extension NSImage {
    /// Initializes `NSImage` with `CGSize` and `NSColor`.
    ///
    ///     let image: NSImage = .init(
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
