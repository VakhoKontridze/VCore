//
//  InnerShadowUIViewUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

#if canImport(UIKit)

import UIKit

// MARK: - Inner Shadow UI View UI Model
/// Model that describes UI.
public struct InnerShadowUIViewUIModel {
    // MARK: Properties
    /// Model that contains color properties.
    public var colors: Colors = .init()
    
    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}
    
    // MARK: Colors
    /// Model that contains color properties.
    public struct Colors {
        // MARK: Properties
        /// Shadow color.
        public var shadowColor: UIColor = .black.withAlphaComponent(0.1)
        
        /// Shadow color. Defaults to `5`.
        public var shadowRadius: CGFloat = 5
        
        /// Shadow color. Defaults to `5` width and `5` height.
        public var shadowOffset: CGSize = .init(width: 5, height: 5)
        
        // MARK: Initializers
        /// Initializes UI model with default values.
        public init() {}
    }
}

#endif
