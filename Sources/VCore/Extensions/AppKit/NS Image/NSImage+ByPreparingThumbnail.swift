//
//  NSImage+ByPreparingThumbnail.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.11.23.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import AppKit

// MARK: - NS Image + By Preparing Thumbnail
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
            flipped: false
        ) { _ in imageRepresentation.draw(in: frame) }

        return thumbnail
    }
}

// MARK: - Preview
#if DEBUG

import SwiftUI

#Preview {
    guard
        let image: NSImage = .init(systemSymbolName: "swift", accessibilityDescription: nil)
    else {
        return EmptyView()
    }

    let dimension: CGFloat = 128

    return VStack {
        Image(nsImage: image)
            .resizable()
            .scaledToFit()
            .frame(dimension: dimension)

        if let thumbnail: NSImage = image.byPreparingThumbnail(ofSize: CGSize(dimension: dimension/4)) { // To make visible
            Image(nsImage: thumbnail)
                .resizable()
                .aspectRatio(1.2, contentMode: .fit)
                .frame(dimension: dimension)
        }
    }
    .padding()
}

#endif

#endif
