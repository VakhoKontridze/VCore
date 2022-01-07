//
//  UIImage.Compressed.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/8/21.
//

import UIKit

// MARK: - Image Compressed
extension UIImage {
    /// Compresses `UIImage` with specified quality.
    ///
    /// Usage Example:
    ///
    ///     let image: UIImage = .init(named: "SomeImage")!
    ///     let compressedImage: UIImage? = image.compressed(quality: 0.75)
    ///
    public func compressed(quality: CGFloat) -> UIImage? {
        jpegData(compressionQuality: quality).let { .init(data: $0) }
    }
}
