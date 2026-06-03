//
//  UIImage+Scaled.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/8/21.
//

#if canImport(UIKit)

public import UIKit

nonisolated extension UIImage {
    /// Scales `UIImage` to specified width.
    ///
    ///     let image: UIImage = .init(named: "Image")!
    ///     let scaledImage: UIImage? = image.scaled(toWidth: 500)
    ///
    public func scaled(
        toWidth newWidth: CGFloat
    ) -> UIImage? {
        scaled(
            toSize: CGSize(
                width: newWidth,
                height: size.height * (newWidth / size.width)
            )
        )
    }
    
    /// Scales `UIImage` to specified height.
    ///
    ///     let image: UIImage = .init(named: "Image")!
    ///     let scaledImage: UIImage? = image.scaled(toHeight: 500)
    ///
    public func scaled(
        toHeight newHeight: CGFloat
    ) -> UIImage? {
        scaled(
            toSize: CGSize(
                width: size.width * (newHeight / size.height),
                height: newHeight
            )
        )
    }
    
    private func scaled(
        toSize newSize: CGSize
    ) -> UIImage? {
#if os(watchOS)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1)
        defer { UIGraphicsEndImageContext() }
        
        draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
        
#else
        
        let format: UIGraphicsImageRendererFormat = .init()
        format.scale = 1
        
        let renderer: UIGraphicsImageRenderer = .init(
            size: newSize,
            format: format
        )
        
        return renderer.image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }
        
#endif
    }
}

nonisolated extension UIImage {
    /// Returns `UIImage` scaled down to specified width, if new width is smaller.
    ///
    ///     let image: UIImage = .init(named: "Image")!
    ///     let scaledDownImage: UIImage? = image.scaledDown(toWidth: 500)
    ///
    public func scaledDown(
        toWidth newWidth: CGFloat
    ) -> UIImage? {
        guard size.width > newWidth else { return self }
        return scaled(toWidth: newWidth)
    }
    
    /// Returns `UIImage` scaled down to specified height, if new height is smaller.
    ///
    ///     let image: UIImage = .init(named: "Image")!
    ///     let scaledDownImage: UIImage? = image.scaledDown(toHeight: 500)
    ///
    public func scaledDown(
        toHeight newHeight: CGFloat
    ) -> UIImage? {
        guard size.height > newHeight else { return self }
        return scaled(toHeight: newHeight)
    }
    
    /// Returns `UIImage` scaled down, by scaling smaller side to specified dimension.
    ///
    ///     let image: UIImage = .init(named: "Image")!
    ///     let scaledDownImage: UIImage? = image.scaledDown(toMinDimension: 500)
    ///
    public func scaledDown(
        toMinDimension newDimension: CGFloat
    ) -> UIImage? {
        if size.width > size.height {
            scaledDown(toHeight: newDimension)
        } else {
            scaledDown(toWidth: newDimension)
        }
    }
    
    /// Returns `UIImage` scaled down, by scaling larger side to specified dimension.
    ///
    ///     let image: UIImage = .init(named: "Image")!
    ///     let scaledDownImage: UIImage? = image.scaledDown(toMaxDimension: 500)
    ///
    public func scaledDown(
        toMaxDimension newDimension: CGFloat
    ) -> UIImage? {
        if size.height > size.width {
            scaledDown(toHeight: newDimension)
        } else {
            scaledDown(toWidth: newDimension)
        }
    }
}

#endif
