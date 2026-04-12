//
//  CapsuleUIView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 26.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

/// `UIView` that rounds corners to capsule.
///
/// If width is greater than height, half of height will be taken as corner radius. If not, otherwise.
open class CapsuleUIView: UIView {
    // MARK: Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Setup
    private func setUp() {
        clipsToBounds = true
        layer.maskedCorners = .layerAllCorners
    }
    
    // MARK: Lifecycle
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = min(frame.size.width, frame.size.height) / 2
    }
}

#if DEBUG

#Preview {
    let view: CapsuleUIView = .init()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor.systemBlue

    NSLayoutConstraint.activate([
        view.widthAnchor.constraint(equalToConstant: 200),
        view.heightAnchor.constraint(equalToConstant: 100)
    ])

    return view
}

#endif

#endif
