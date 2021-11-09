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
        toHeight newHeight: CGFloat
    ) -> UIImage? {
        scaled(toSize: .init(
            width: size.width * (newHeight / size.height),
            height: newHeight
        ))
    }
    
    /// Scales `UIImage` to specified width.
    public func scaled(
        toWidth newWidth: CGFloat
    ) -> UIImage? {
        scaled(toSize: .init(
            width: newWidth,
            height: size.height * (newWidth / size.width)
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
