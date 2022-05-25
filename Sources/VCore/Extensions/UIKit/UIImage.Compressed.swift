//
//  UIImage.Compressed.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/8/21.
//

#if canImport(UIKit)

import UIKit

// MARK: - Image Compressed
extension UIImage {
    /// Returns `UIImage` compressed with specified quality.
    ///
    ///     let image: UIImage = .init(named: "SomeImage")!
    ///     let compressedImage: UIImage? = image.compressed(quality: 0.75)
    ///
    public func compressed(quality: CGFloat) -> UIImage? {
        jpegData(compressionQuality: quality).flatMap { .init(data: $0) }
    }
}

#endif
