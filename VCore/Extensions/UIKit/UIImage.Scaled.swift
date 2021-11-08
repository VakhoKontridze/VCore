//
//  UIImage.Scaled.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/8/21.
//

import UIKit

// MARK: - Image Scaling
extension UIImage {
    /// Scales `UIImage` to specified height.
    public func scaled(
        toHeight newHeight: CGFloat,
        opaque: Bool = false
    ) -> UIImage? {
        let newSize: CGSize = .init(
            width: size.width * (newHeight / size.height),
            height: newHeight
        )
        
        UIGraphicsBeginImageContextWithOptions(newSize, opaque, scale)
        defer { UIGraphicsEndImageContext() }
        
        draw(in: .init(origin: .zero, size: newSize))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// Scales `UIImage` to specified width.
    public func scaled(
        toWidth newWidth: CGFloat,
        opaque: Bool = false
    ) -> UIImage? {
        let newSize: CGSize = .init(
            width: newWidth,
            height: size.height * (newWidth / size.width)
        )
        
        UIGraphicsBeginImageContextWithOptions(newSize, opaque, scale)
        defer { UIGraphicsEndImageContext() }
        
        draw(in: .init(origin: .zero, size: newSize))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
