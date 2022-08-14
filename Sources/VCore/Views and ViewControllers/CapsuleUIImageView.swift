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
        
        layer.cornerRadius = {
            if frame.size.width > frame.size.height {
                return frame.size.height / 2
            } else {
                return frame.size.width / 2
            }
        }()
    }
}

#endif
