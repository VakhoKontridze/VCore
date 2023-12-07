//
//  NSImage.ByPreparingThumbnail.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.11.23.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import AppKit

// MARK: - Image by Preparing Thumbnail
extension NSImage {
    /// Returns a new thumbnail `NSImage` at the specified `CGSize`.
    ///
    ///     let thumbnail: NSImage? = NSImage(named: "Image")?
    ///         .byPreparingThumbnail(ofSize: CGSize(dimension: 32))
    ///
    public func byPreparingThumbnail(
        ofSize size: CGSize
    ) -> NSImage? {
        let frame: NSRect = .init(
            origin: CGPoint.zero,
            size: size
        )

        guard
            let imageRepresentation: NSImageRep = bestRepresentation(
                for: frame,
                context: nil,
                hints: nil
            )
        else {
            return nil
        }

        let thumbnail: NSImage = .init(
            size: size,
            flipped: false,
            drawingHandler: { _ in imageRepresentation.draw(in: frame) }
        )

        return thumbnail
    }
}

#endif
