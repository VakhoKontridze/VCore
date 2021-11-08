//
//  UIImage.Compressed.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/8/21.
//

import UIKit

// MARK: - Image Compressed
extension UIImage {
    /// Compressed `UIImage` with specified quality.
    public func compressed(quality: CGFloat) -> UIImage? {
        jpegData(compressionQuality: quality).let { .init(data: $0) }
    }
}
