//
//  UIImage+ByPreparingThumbnailWatchOS.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 3/6/26.
//

#if canImport(UIKit)

import ImageIO
import UIKit

extension UIImage {
    func byPreparingThumbnailWatchOS(
        ofSize size: CGSize
    ) -> UIImage? {
        guard let cgImage else {
            return nil
        }
        
        let pixelSize: CGSize = .init(
            width: size.width * scale,
            height: size.height * scale
        )
        
        guard
            let context: CGContext = .init(
                data: nil,
                width: Int(pixelSize.width),
                height: Int(pixelSize.height),
                bitsPerComponent: 8,
                bytesPerRow: 0,
                space: CGColorSpaceCreateDeviceRGB(),
                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
            )
        else {
            return nil
        }
        
        context.interpolationQuality = .high
        
        context.draw(
            cgImage,
            in: CGRect(origin: .zero, size: pixelSize)
        )
        
        guard let scaledCGImage: CGImage = context.makeImage() else {
            return nil
        }
        
        return UIImage(
            cgImage: scaledCGImage,
            scale: scale,
            orientation: imageOrientation
        )
    }
}

#endif
