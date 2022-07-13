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
    private let innerShadowShapeLayer: CAShapeLayer = {
        let shapeLayer: CAShapeLayer = .init()
        shapeLayer.shadowOpacity = 1
        shapeLayer.fillRule = .evenOdd
        return shapeLayer
    }()
    
    // MARK: Properties
    private var uiModel: InnerShadowUIViewUIModel

    // MARK: Initializers
    /// Initializes `InnerShadowUIView`.
    public init(uiModel: InnerShadowUIViewUIModel = .init()) {
        self.uiModel = uiModel
        super.init(frame: .zero)
        setUp()
        configure(uiModel: uiModel)
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
    
    // MARK: Configuration - UI Model
    /// Configures `InnerShadowUIView` with `InnerShadowUIViewUIModel`.
    open func configure(uiModel: InnerShadowUIViewUIModel) {
        self.uiModel = uiModel
        
        innerShadowShapeLayer.shadowColor = uiModel.colors.shadowColor.cgColor
        innerShadowShapeLayer.shadowRadius = uiModel.colors.shadowRadius
        innerShadowShapeLayer.shadowOffset = uiModel.colors.shadowOffset
    }
}

#endif
