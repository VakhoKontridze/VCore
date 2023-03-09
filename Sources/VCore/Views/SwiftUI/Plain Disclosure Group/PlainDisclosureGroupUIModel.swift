//
//  PlainDisclosureGroupUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 22.06.22.
//

#if os(iOS)

import SwiftUI

// MARK: - Plain Disclosure Group UI Model
/// Model that describes UI.
public struct PlainDisclosureGroupUIModel {
    // MARK: Properties
    /// Model that contains layout properties. 
    public var layout: Layout = .init()
    
    /// Model that contains color properties.
    public var colors: Colors = .init()
    
    /// Model that contains animation properties.
    public var animations: Animations = .init()
    
    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}
    
    // MARK: Layout
    /// Model that contains layout properties.
    public struct Layout {
        // MARK: Properties
        /// Default padding in native disclosure group. Set to `8`.
        ///
        /// Value is used during the frame calculations, and must be provided.
        ///
        /// In future releases of `iOS`/`macOS`, this value may change.
        public var defaultDisclosureGroupPadding: CGFloat = 8
        
        // MARK: Initializers
        /// Initializes UI model with default values.
        public init() {}
    }

    // MARK: Colors
    /// Model that contains color properties.
    public struct Colors {
        // MARK: Properties
        /// Background color.
        ///
        /// Needed for setting background color to the label.
        public var background: Color = .init(.systemBackground)
        
        // MARK: Initializers
        /// Initializes UI model with default values.
        public init() {}
    }
    
    // MARK: Animations
    /// Model that contains animation properties.
    public struct Animations {
        // MARK: Properties
        /// Expand and collapse animation. Set to `default`.
        public var expandCollapse: Animation? = .default
        
        // MARK: Initializers
        /// Initializes UI model with default values.
        public init() {}
    }
}

#endif
