//
//  DelegatingAsyncImageUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.03.23.
//

import SwiftUI

// MARK: - Delegating Async Image UI Model
/// Model that describes UI.
public struct DelegatingAsyncImageUIModel {
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
        /// Default placeholder color.
        public var placeholder: Color = .gray.opacity(0.3)
        
        // MARK: Initializers
        /// Initializes UI model with default values.
        public init() {}
    }
}
