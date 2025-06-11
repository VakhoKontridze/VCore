//
//  CapsuleUIView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 26.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Capsule View
/// `UIView` that rounds corners to capsule.
///
/// If width is greater than height, half of height will be taken as corner radius. If not, otherwise.
open class CapsuleUIView: UIView {
    // MARK: Lifecycle
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        // `clipsToBounds` and `layer.maskedCorners` are not necessary.
        // Plus, they conflict with shadows.
        layer.cornerRadius = min(frame.size.width, frame.size.height) / 2
    }
}

// MARK: - Preview
#if DEBUG

#Preview {
    let view: CapsuleUIView = .init()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor.systemBlue

    NSLayoutConstraint.activate([
        view.constraintWidth(to: nil, constant: 100),
        view.constraintHeight(to: nil, constant: 100)
    ])

    return view
}

#endif

#endif
