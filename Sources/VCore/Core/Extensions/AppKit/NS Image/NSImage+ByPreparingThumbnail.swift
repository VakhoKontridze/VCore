//
//  NSImage+ByPreparingThumbnail.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.11.23.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import AppKit

nonisolated extension NSImage {
    /// Returns a new thumbnail `NSImage` at the specified `CGSize`.
    ///
    ///     let thumbnail: NSImage? = NSImage(named: "Image")?
    ///         .byPreparingThumbnail(ofSize: CGSize(dimension: 32))
    ///
    public func byPreparingThumbnail(
        ofSize size: CGSize
    ) -> NSImage? {
        guard
            let cgImage: CGImage = cgImage(
                forProposedRect: nil,
                context: nil,
                hints: nil
            )
        else {
            return nil
        }

        let thumbnail: NSImage = .init(
            size: size,
            flipped: false
        ) { frame in
            guard
                let context: CGContext = NSGraphicsContext.current?.cgContext
            else {
                return false
            }
            context.interpolationQuality = .high
            context.draw(cgImage, in: frame)
            
            return true
        }

        return thumbnail
    }
}

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
