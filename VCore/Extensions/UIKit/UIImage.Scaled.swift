//
//  UIImage.Scaled.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/8/21.
//

import UIKit

// MARK: - Image Scaling
extension UIImage {
    /// Scales `UIImage` to specified width.
    ///
    /// Usage Example:
    ///
    ///     let image: UIImage = .init(named: "SomeImage")!
    ///     let scaledImage: UIImage? = image.scaled(toWidth: 500)
    ///
    public func scaled(
        toWidth newWidth: CGFloat
    ) -> UIImage? {
        scaled(toSize: .init(
            width: newWidth,
            height: size.height * (newWidth / size.width)
        ))
    }
    
    /// Scales `UIImage` to specified height.
    ///
    /// Usage Example:
    ///
    ///     let image: UIImage = .init(named: "SomeImage")!
    ///     let scaledImage: UIImage? = image.scaled(toHeight: 500)
    ///
    public func scaled(
        toHeight newHeight: CGFloat
    ) -> UIImage? {
        scaled(toSize: .init(
            width: size.width * (newHeight / size.height),
            height: newHeight
        ))
    }
    
    private func scaled(
        toSize newSize: CGSize
    ) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1)
        defer { UIGraphicsEndImageContext() }
        
        draw(in: .init(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

// MARK: - Image Scaling Down
extension UIImage {
    /// Scales `UIImage` down to specified width, if new width is smaller.
    ///
    /// Usage Example:
    ///
    ///     let image: UIImage = .init(named: "SomeImage")!
    ///     let scaledDownImage: UIImage? = image.scaledDown(toWidth: 500)
    ///
    public func scaledDown(
        toWidth newWidth: CGFloat
    ) -> UIImage? {
        guard self.size.width > newWidth else { return self }
        return scaled(toWidth: newWidth)
    }
    
    /// Scales `UIImage` down to specified height, if new height is smaller.
    ///
    /// Usage Example:
    ///
    ///     let image: UIImage = .init(named: "SomeImage")!
    ///     let scaledDownImage: UIImage? = image.scaledDown(toHeight: 500)
    ///
    public func scaledDown(
        toHeight newHeight: CGFloat
    ) -> UIImage? {
        guard self.size.height > newHeight else { return self }
        return scaled(toHeight: newHeight)
    }
    
    /// Scales `UIImage` down, by scaling smaller side to specified dimension.
    ///
    /// Usage Example:
    ///
    ///     let image: UIImage = .init(named: "SomeImage")!
    ///     let scaledDownImage: UIImage? = image.scaledDown(toDimension: 500)
    ///
    public func scaledDown(
        toDimension newDimension: CGFloat
    ) -> UIImage? {
        switch self.size.width > self.size.height {
        case false: return scaledDown(toWidth: newDimension)
        case true: return scaledDown(toHeight: newDimension)
        }
    }
}
