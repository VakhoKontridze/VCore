//
//  CapsuleUIImageView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 26.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Capsule UI Image View
/// `UIImageView` that rounds corners to capsule.
///
/// `clipsToBounds` is set to `true`, and `layer.maskedCorners` is set to `layerAllCorners`.
///
/// If width is greater than height, half of height will be taken as corner radius. If not, otherwise.
open class CapsuleUIImageView: UIImageView {
    // MARK: Lifecycle
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        clipsToBounds = true
        layer.maskedCorners = .layerAllCorners
        layer.cornerRadius = min(frame.size.width, frame.size.height) / 2
    }
}

// MARK: - Preview
#if DEBUG

#Preview(body: {
    guard
        let image: UIImage = .init(
            size: CGSize(dimension: 100),
            color: UIColor.systemBlue
        )
    else {
        return UIView()
    }

    return CapsuleUIImageView(image: image)
})

#endif

#endif
