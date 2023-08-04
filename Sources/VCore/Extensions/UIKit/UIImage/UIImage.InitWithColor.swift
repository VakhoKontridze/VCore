//
//  UIImage.InitWithColor.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit)

import UIKit

// MARK: - Image Init with Color
extension UIImage {
    /// Initializes `UIImage` with color and size.
    ///
    ///     let image: UIImage = .init(
    ///         size: CGSize(dimension: 100),
    ///         color: .black
    ///     )!
    ///
    public convenience init?(
        size: CGSize,
        color: UIColor
    ) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        defer { UIGraphicsEndImageContext() }
        
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        
        guard let cgImage: CGImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

#endif
