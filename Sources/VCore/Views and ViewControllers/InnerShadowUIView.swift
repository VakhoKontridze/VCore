//
//  InnerShadowUIView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

#if canImport(UIKit)

import UIKit

// MARK: - Inner Shadow UI View
/// `UIView` that casts inner shadow.
open class InnerShadowUIView: UIView {
    // MARK: Subviews
    private lazy var innerShadowShapeLayer: CAShapeLayer = {
        let shapeLayer: CAShapeLayer = .init()
        shapeLayer.shadowOpacity = 1
        shapeLayer.shadowColor = shadowColor.cgColor
        shapeLayer.shadowRadius = shadowRadius
        shapeLayer.shadowOffset = shadowOffset
        shapeLayer.fillRule = .evenOdd
        return shapeLayer
    }()
    
    // MARK: Properties
    private let shadowColor: UIColor
    private let shadowRadius: CGFloat
    private let shadowOffset: CGSize

    // MARK: Initializers
    /// Initializes `InnerShadowUIView` with color, radius, and offset.
    public init(
        shadowColor: UIColor,
        shadowRadius: CGFloat,
        shadowOffset: CGSize
    ) {
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.shadowOffset = shadowOffset
        
        super.init(frame: .zero)
        
        setUp()
    }
    
    required public init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: Lifecycle
    open override func layoutSubviews() {
        super.layoutSubviews()

        innerShadowShapeLayer.path = {
            let path: CGMutablePath = .init()
            let inset: CGFloat = -innerShadowShapeLayer.shadowRadius * 2
            path.addRect(bounds.insetBy(dx: inset, dy: inset))
            path.addRect(bounds)
            return path
        }()
    }
    
    // MARK: Setup
    private func setUp() {
        layer.masksToBounds = true
        layer.addSublayer(innerShadowShapeLayer)
    }
}

#endif
