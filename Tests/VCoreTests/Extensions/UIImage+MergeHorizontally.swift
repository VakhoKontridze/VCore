//
//  UIImage.MergeHorizontally.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit)

import UIKit

// MARK: - Image + Merge Horizontally
extension UIImage {
    // Doesn't consider positioning. Only used for testing purposes,
    // when `lhs.size` equals `rhs.size`.
    static func mergeHorizontally(_ lhs: UIImage, with rhs: UIImage) -> UIImage? {
        let newSize: CGSize = .init(
            width: lhs.size.width + rhs.size.width,
            height: max(lhs.size.height, rhs.size.height)
        )
        
        UIGraphicsBeginImageContext(newSize)
        defer { UIGraphicsEndImageContext() }
        
        lhs.draw(in: CGRect(origin: .zero, size: newSize))
        rhs.draw(in: CGRect(origin: CGPoint(x: lhs.size.width, y: 0), size: newSize))
        let mergedImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        
        return mergedImage
    }
}

#endif
