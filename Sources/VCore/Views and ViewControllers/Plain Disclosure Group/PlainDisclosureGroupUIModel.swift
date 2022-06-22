//
//  PlainDisclosureGroupUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 22.06.22.
//

import SwiftUI

// MARK: - Plain Disclosure Group UI Model
/// Model that describes UI.
public struct PlainDisclosureGroupUIModel {
    // MARK: Properties
    /// Sub-model containing layout properties.
    var layout: Layout = .init()
    
    /// Sub-model containing color properties.
    var colors: Colors = .init()
    
    /// Sub-model containing animation properties.
    var animations: Animations = .init()
    
    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}
    
    // MARK: Layout
    /// Sub-model containing layout properties.
    struct Layout {
        // MARK: Properties
        /// Default padding in native diclsosure group. Defaults to `8`.
        ///
        /// Value is used during the frame calculations, and must be provided.
        ///
        /// In future releases of `iOS`/`macOS`, this value may change.
        public var defaultDisclosureGroupPadding: CGFloat = 8
        
        // MARK: Initializers
        /// Initializes sub-model with default values.
        public init() {}
    }

    // MARK: Colors
    /// Sub-model containing color properties.
    struct Colors {
        // MARK: Properties
        /// Background color.
        ///
        /// Needed for giving a bakcground color to the label.
        public var background: Color = .init(.systemBackground)
        
        // MARK: Initializers
        /// Initializes sub-model with default values.
        public init() {}
    }
    
    // MARK: Animations
    /// Sub-model containing animation properties.
    struct Animations {
        // MARK: Properties
        /// Expand and collapse animation. Defaults to `default`.
        public var expandCollapse: Animation? = .default
        
        // MARK: Initializers
        /// Initializes sub-model with default values.
        public init() {}
    }
}