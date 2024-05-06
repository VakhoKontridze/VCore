//
//  UIImage.Cropped.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/8/21.
//

#if canImport(UIKit)

import UIKit

// MARK: - UI Image Cropped
extension UIImage {
    /// Returns `UIImage` cropped with rect.
    ///
    ///     let image: UIImage = .init(named: "Image")!
    ///
    ///     let croppedImage: UIImage? = image.cropped(to: CGRect(
    ///         origin: CGPoint(x: 10, y: 10),
    ///         size: CGSize(width: 500, height: 500)
    ///     ))
    ///
    public func cropped(to newRect: CGRect) -> UIImage {
        guard
            newRect.size.width <= size.width,
            newRect.size.height <= size.height,
            
            let croppedImage: CGImage = cgImage?.cropping(to: newRect.applying(CGAffineTransform(
                scaleX: scale,
                y: scale
            )))
        else {
            return self
        }
        
        return UIImage(
            cgImage: croppedImage,
            scale: scale,
            orientation: imageOrientation
        )
    }
    
    /// Returns `UIImage`cropped with size starting at the origin.
    ///
    ///     let image: UIImage = .init(named: "Image")!
    ///
    ///     let croppedImage: UIImage? = image.cropped(to: CGSize(
    ///         width: 500,
    ///         height: 500
    ///     ))
    ///
    public func cropped(to newSize: CGSize) -> UIImage {
        cropped(to: CGRect(origin: .zero, size: newSize))
    }
}

// MARK: - Preview
#if DEBUG

import SwiftUI

#Preview(body: {
    guard
        let image: UIImage = .init(systemName: "swift")
    else {
        return EmptyView()
    }

    let croppedImage: UIImage = image.cropped(
        to: CGRect(
            origin: CGPoint(x: image.size.width/2, y: image.size.height/2),
            size: image.size.scaledDown(withMultiplier: 2)
        )
    )

    return VStack(content: {
        Image(uiImage: image)
            .resizable()
            .frame(dimension: 100)

        Image(uiImage: croppedImage)
            .resizable()
            .frame(dimension: 100)
    })
})

#endif

#endif
