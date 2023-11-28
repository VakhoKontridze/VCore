//
//  NSImage.InitWithColor.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28.11.23.
//

#if canImport(AppKit)

import AppKit

// MARK: - Image Init with Color
extension NSImage {
    /// Initializes `UIImage` with `CGSize` and `NSColor`.
    ///
    ///     let image: UIImage = .init(
    ///         size: CGSize(dimension: 100),
    ///         color: .systemBlue
    ///     )!
    ///
    public convenience init?(
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

#endif
