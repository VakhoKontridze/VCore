//
//  InnerShadowUIView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

/// `UIView` that casts an inner shadow.
open class InnerShadowUIView: UIView {
    // MARK: Properties - Appearance
    /// Model that describes appearance.
    ///
    /// To change current appearance, use `configure(appearance:)` method.
    private(set) var appearance: InnerShadowUIViewAppearance
    
    // MARK: Properties - Subviews
    /// Shape layer.
    open private(set) var shapeLayer: CAShapeLayer = {
        let shapeLayer: CAShapeLayer = .init()
        shapeLayer.shadowOpacity = 1
        shapeLayer.fillRule = .evenOdd
        return shapeLayer
    }()
    
    // MARK: Initializers
    /// Initializes `InnerShadowUIView`.
    public init(
        appearance: InnerShadowUIViewAppearance = .init()
    ) {
        self.appearance = appearance
        super.init(frame: .zero)
        setUp()
        configure(appearance: appearance)
    }
    
    @available(*, unavailable)
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
    
    // MARK: Configuration - Appearance
    /// Configures `InnerShadowUIView` with `InnerShadowUIViewAppearance`.
    open func configure(appearance: InnerShadowUIViewAppearance) {
        self.appearance = appearance
        
        shapeLayer.shadowColor = appearance.shadowColor.cgColor
        shapeLayer.shadowRadius = appearance.shadowRadius
        shapeLayer.shadowOffset = appearance.shadowOffset
        
        setNeedsLayout()
    }
}

#if DEBUG

#Preview {
    let view: InnerShadowUIView = .init(
        appearance: {
            var appearance: InnerShadowUIViewAppearance = .init()
            appearance.shadowColor = UIColor.systemBlue
            return appearance
        }()
    )
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.67)

    NSLayoutConstraint.activate([
        view.widthAnchor.constraint(equalToConstant: 100),
        view.heightAnchor.constraint(equalToConstant: 100)
    ])

    return view
}

#endif

#endif
