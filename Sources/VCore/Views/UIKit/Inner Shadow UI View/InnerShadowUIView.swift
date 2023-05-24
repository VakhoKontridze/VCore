//
//  InnerShadowUIView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Inner Shadow UI View
/// `UIView` that casts an inner shadow.
open class InnerShadowUIView: UIView {
    // MARK: Subviews
    /// Shape layer.
    open var shapeLayer: CAShapeLayer = {
        let shapeLayer: CAShapeLayer = .init()
        shapeLayer.shadowOpacity = 1
        shapeLayer.fillRule = .evenOdd
        return shapeLayer
    }()
    
    // MARK: Properties
    /// Model that describes UI.
    ///
    /// To change current UI model, use `configure(uiModel)` method.
    private(set) var uiModel: InnerShadowUIViewUIModel
    
    // MARK: Initializers
    /// Initializes `InnerShadowUIView`.
    public init(
        uiModel: InnerShadowUIViewUIModel = .init()
    ) {
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
        
        shapeLayer.path = {
            let inset: CGFloat = -shapeLayer.shadowRadius * 2
            
            let path: CGMutablePath = .init()
            
            path.addRect(bounds.insetBy(dx: inset, dy: inset))
            path.addRect(bounds)
            
            return path
        }()
    }
    
    // MARK: Setup
    /// Sets up `InnerShadowUIView`.
    open func setUp() {
        layer.masksToBounds = true
        layer.addSublayer(shapeLayer)
    }
    
    // MARK: Configuration - UI Model
    /// Configures `InnerShadowUIView` with `InnerShadowUIViewUIModel`.
    open func configure(uiModel: InnerShadowUIViewUIModel) {
        self.uiModel = uiModel
        
        shapeLayer.shadowColor = uiModel.colors.shadowColor.cgColor
        shapeLayer.shadowRadius = uiModel.colors.shadowRadius
        shapeLayer.shadowOffset = uiModel.colors.shadowOffset
    }
}

#endif
