//
//  UIImage.Cropped.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/8/21.
//

import UIKit

// MARK: - Image Crop
extension UIImage {
    /// Cropps `UIImage` with specified rect.
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
    
    /// Cropps `UIImage` with specified size starting at the origin.
    public func cropped(to newSize: CGSize) -> UIImage {
        cropped(to: .init(origin: .zero, size: newSize))
    }
}
