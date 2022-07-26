//
//  CapsuleUIImageView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 26.07.22.
//

#if canImport(UIKit)

import UIKit

// MARK: - Capsule View
/// `UIImageView` that rounds corners to capsule.
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
