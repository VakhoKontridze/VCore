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
    public func scaled(
        toWidth newWidth: CGFloat
    ) -> UIImage? {
        scaled(toSize: .init(
            width: newWidth,
            height: size.height * (newWidth / size.width)
        ))
    }
    
    /// Scales `UIImage` to specified height.
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
    ) -> UIImage {
        UIGraphicsImageRenderer(size: newSize).image { _ in
            draw(in: .init(origin: .zero, size: newSize))
        }
    }
}

// MARK: - Image Scaling Down
extension UIImage {
    /// Scales `UIImage` down to specified width, if new width is smaller.
    public func scaledDown(
        toWidth newWidth: CGFloat
    ) -> UIImage? {
        guard self.size.width > newWidth else { return self }
        return scaled(toWidth: newWidth)
    }
    
    /// Scales `UIImage` down to specified height, if new height is smaller.
    public func scaledDown(
        toHeight newHeight: CGFloat
    ) -> UIImage? {
        guard self.size.height > newHeight else { return self }
        return scaled(toHeight: newHeight)
    }
    
    /// Scales `UIImage` down, by scaling smaller side to specified dimension.
    public func scaledDown(
        toDimension newDimension: CGFloat
    ) -> UIImage? {
        switch self.size.width > self.size.height {
        case false: return scaledDown(toWidth: newDimension)
        case true: return scaledDown(toHeight: newDimension)
        }
    }
}
