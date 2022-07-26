//
//  CapsuleUIImageView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 26.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Capsule View
/// `UIImageView` that rounds corners to capsule.
///
/// `clipsToBounds` is set to `true`, and `layer.maskedCorners` is set to `layerAllCorners`.
open class CapsuleImageView: UIImageView {
    // MARK: Lifecycle
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        clipsToBounds = true
        layer.maskedCorners = .layerAllCorners
        layer.cornerRadius = frame.height / 2
    }
}

#endif
