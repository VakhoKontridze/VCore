//
//  UIImage+InitWithUIColor.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit)

import UIKit

// MARK: - UI Image + Init with UI Color
extension UIImage {
    /// Initializes `UIImage` with `CGSize` and `UIColor`.
    ///
    ///     let image: UIImage = .init(
    ///         size: CGSize(dimension: 100),
    ///         color: UIColor.systemBlue
    ///     )!
    ///
    convenience public init?(
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
