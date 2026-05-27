//
//  NSImage+JPEGData.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 23/5/26.
//

#if canImport(AppKit)

public import AppKit

extension NSImage {
    /// Returns `Data` that contains the image in JPEG format.
    ///
    ///     let data: Data = image.jpegData(compressionQuality: 0.9)
    ///
    nonisolated public func jpegData(compressionQuality: CGFloat) -> Data? {
        guard
            let tiffData: Data = tiffRepresentation,
            let bitmap: NSBitmapImageRep = .init(data: tiffData)
        else {
            return nil
        }
        
        return bitmap.representation(
            using: .jpeg,
            properties: [
                .compressionFactor: compressionQuality
            ]
        )
    }
}

#endif
