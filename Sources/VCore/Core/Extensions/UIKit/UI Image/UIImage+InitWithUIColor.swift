//
//  UIImage+InitWithUIColor.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit)

import UIKit

nonisolated extension UIImage {
    /// Initializes `UIImage` with `CGSize` and `UIColor`.
    ///
    ///     let image: UIImage = .init(
    ///         size: CGSize(dimension: 100),
    ///         color: UIColor.systemBlue
    ///     )!
    ///
    public convenience init?(
        size: CGSize,
        color: UIColor
    ) {
        let renderer: UIGraphicsImageRenderer = .init(
            size: size
        )
        
        let renderedImage: UIImage = renderer.image { _ in
            color.setFill()
            UIRectFill(CGRect(origin: .zero, size: size))
        }
        
        guard
            let cgImage: CGImage = renderedImage.cgImage
        else {
            return nil
        }
        
        self.init(cgImage: cgImage)
    }
}

#endif
