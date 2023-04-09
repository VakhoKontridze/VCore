//
//  PlainDisclosureGroupUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 22.06.22.
//

import SwiftUI

// MARK: - Plain Disclosure Group UI Model
/// Model that describes UI.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct PlainDisclosureGroupUIModel {
    // MARK: Properties
    /// Model that contains color properties.
    public var colors: Colors = .init()
    
    /// Model that contains animation properties.
    public var animations: Animations = .init()
    
    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}
    
    // MARK: Colors
    /// Model that contains color properties.
    public struct Colors {
        // MARK: Properties
        /// Background color.
        ///
        /// Needed for setting background color to the label.
        public var background: Color = {
#if os(iOS)
            return Color(UIColor.systemBackground)
#elseif os(macOS)
            return Color(NSColor.windowBackgroundColor)
#else
            fatalError() // Not supported
#endif
        }()
        
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
