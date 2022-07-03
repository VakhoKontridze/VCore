//
//  UIImage.Cropped.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/8/21.
//

#if canImport(UIKit)

import UIKit

// MARK: - Image Crop
extension UIImage {
    /// Returns `UIImage` cropped with rect.
    ///
    ///     let image: UIImage = .init(named: "SomeImage")!
    ///
    ///     let croppedImage: UIImage? = image.cropped(to: .init(
    ///         origin: .init(x: 10, y: 10),
    ///         size: .init(width: 500, height: 500)
    ///     ))
    ///
    public func cropped(to newRect: CGRect) -> UIImage {
        guard
            newRect.size.width <= size.width,
            newRect.size.height <= size.height,
            
            let croppedImage: CGImage = cgImage?.cropping(to: newRect.applying(.init(scaleX: scale, y: scale)))
        else {
            return self
        }
        
        return .init(
            cgImage: croppedImage,
            scale: scale,
            orientation: imageOrientation
        )
    }
    
    /// Returns `UIImage`cropped with size starting at the origin.
    ///
    ///     let image: UIImage = .init(named: "SomeImage")!
    ///
    ///     let croppedImage: UIImage? = image.cropped(to: .init(
    ///         width: 500,
    ///         height: 500
    ///     ))
    ///
    public func cropped(to newSize: CGSize) -> UIImage {
        cropped(to: .init(origin: .zero, size: newSize))
    }
}

#endif
