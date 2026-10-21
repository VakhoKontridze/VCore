//
//  CGImage+Decoded.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21/10/26.
//

import CoreGraphics

nonisolated extension CGImage {
    // Draws image into a bitmap, so pixels are decoded ahead of the first draw
    func decoded() -> CGImage? {
        // Non-RGB color spaces, such as CMYK or grayscale, can't back an RGBA bitmap context
        let colorSpace: CGColorSpace = {
            if
                let colorSpace,
                colorSpace.model == .rgb
            {
                colorSpace
            } else {
                CGColorSpaceCreateDeviceRGB()
            }
        }()

        guard
            let context: CGContext = .init(
                data: nil,
                width: width,
                height: height,
                bitsPerComponent: 8,
                bytesPerRow: 0,
                space: colorSpace,
                bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue // BGRA, which is the native display format
            )
        else {
            return nil
        }

        context.draw(
            self,
            in: CGRect(x: 0, y: 0, width: width, height: height)
        )

        return context.makeImage()
    }
}
