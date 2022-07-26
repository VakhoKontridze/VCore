//
//  CapsuleUIView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 26.07.22.
//

#if canImport(UIKit)

import UIKit

// MARK: - Capsule View
/// `UIView` that rounds corners to capsule.
open class CapsuleUIView: UIView {
    // MARK: Lifecycle
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        // `clipsToBounds` and `layer.maskedCorners` are not necessary and they conflict with shadows
        layer.cornerRadius = frame.height / 2
    }
}

#endif
