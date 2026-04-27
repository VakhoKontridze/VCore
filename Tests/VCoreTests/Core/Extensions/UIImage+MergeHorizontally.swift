//
//  UIImage.MergeHorizontally.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit)

import UIKit

extension UIImage {
    // Doesn't consider positioning. Only used for testing purposes,
    // when `lhs.size` equals `rhs.size`.
    static func mergeHorizontally(_ lhs: UIImage, with rhs: UIImage) -> UIImage {
        let newSize = CGSize(
            width: lhs.size.width + rhs.size.width,
            height: max(lhs.size.height, rhs.size.height)
        )

        let renderer: UIGraphicsImageRenderer = .init(size: newSize)
        
        return renderer.image { _ in
            lhs.draw(in: CGRect(origin: .zero, size: lhs.size))
            rhs.draw(in: CGRect(origin: CGPoint(x: lhs.size.width, y: 0), size: rhs.size))
        }
    }
}

#endif
