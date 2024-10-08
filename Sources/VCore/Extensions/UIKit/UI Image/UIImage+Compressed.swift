//
//  UIImage+Compressed.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/8/21.
//

#if canImport(UIKit)

import UIKit

// MARK: - UI Image + Compressed
extension UIImage {
    /// Returns `UIImage` compressed with specified quality.
    ///
    ///     let image: UIImage = .init(named: "Image")!
    ///     let compressedImage: UIImage? = image.jpegCompressed(quality: 0.75)
    ///
    public func jpegCompressed(quality: CGFloat) -> UIImage? {
        jpegData(compressionQuality: quality).flatMap { UIImage(data: $0) }
    }
}

#endif
