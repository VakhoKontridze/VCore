//
//  NSImage+ByPreparingForDisplay.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21/10/26.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

public import AppKit

nonisolated extension NSImage {
    /// Returns a new `NSImage` with a decoded bitmap, ready for display.
    ///
    /// Returns `nil` if image has no bitmap representation,
    /// such as a vector image or one drawn by a handler, as they have no intrinsic pixel size.
    ///
    ///     let image: NSImage? = NSImage(contentsOfFile: path)?
    ///         .byPreparingForDisplay()
    ///
    public func byPreparingForDisplay() -> NSImage? {
        guard
            representations.contains(where: { $0.pixelsWide > 0 && $0.pixelsHigh > 0 }),
            let cgImage: CGImage = cgImage(
                forProposedRect: nil,
                context: nil,
                hints: nil
            ),
            let decodedCGImage: CGImage = cgImage.decoded()
        else {
            return nil
        }

        let image: NSImage = .init(
            cgImage: decodedCGImage,
            size: size
        )
        image.isTemplate = isTemplate

        return image
    }
}

#endif
