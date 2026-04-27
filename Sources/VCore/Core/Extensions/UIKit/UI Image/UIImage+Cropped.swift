//
//  UIImage+Cropped.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/8/21.
//

#if canImport(UIKit)

import UIKit

nonisolated extension UIImage {
    /// Returns `UIImage` cropped with rect.
    ///
    ///     let image: UIImage = .init(named: "Image")!
    ///
    ///     let croppedImage: UIImage? = image.cropped(
    ///         to: CGRect(
    ///             origin: CGPoint(x: 10, y: 10),
    ///             size: CGSize(width: 500, height: 500)
    ///         )
    ///     )
    ///
    public func cropped(to newRect: CGRect) -> UIImage {
        let normalizedImage: UIImage = {
            guard imageOrientation != .up else { return self }
            
            let renderer: UIGraphicsImageRenderer = .init(size: size)
            
            return renderer.image { _ in
                draw(in: CGRect(origin: .zero, size: size))
            }
        }()
        
        guard
            newRect.size.width <= normalizedImage.size.width,
            newRect.size.height <= normalizedImage.size.height,
            
            let croppedImage: CGImage = normalizedImage.cgImage?.cropping(
                to: newRect.applying(
                    CGAffineTransform(
                        scaleX: scale,
                        y: scale
                    )
                )
            )
        else {
            return self
        }
        
        return UIImage(
            cgImage: croppedImage,
            scale: scale,
            orientation: .up
        )
    }
    
    /// Returns `UIImage`cropped with size starting at the origin.
    ///
    ///     let image: UIImage = .init(named: "Image")!
    ///
    ///     let croppedImage: UIImage? = image.cropped(
    ///         to: CGSize(
    ///             width: 500,
    ///             height: 500
    ///         )
    ///     )
    ///
    public func cropped(to newSize: CGSize) -> UIImage {
        cropped(to: CGRect(origin: .zero, size: newSize))
    }
}

#if DEBUG

import SwiftUI

#Preview {
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

    return VStack {
        Image(uiImage: image)
            .resizable()
            .frame(dimension: 100)

        Image(uiImage: croppedImage)
            .resizable()
            .frame(dimension: 100)
    }
}

#endif

#endif
