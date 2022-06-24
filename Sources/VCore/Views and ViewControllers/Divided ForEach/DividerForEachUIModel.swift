//
//  DividerForEachUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 24.06.22.
//

import SwiftUI

// MARK: - Divided ForEach UI Model
/// Model that describes UI.
public struct DividedForEachUIModel {
    // MARK: Properties
    /// Sub-model containing layout properties.
    public var layout: Layout = .init()
    
    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}
    
    // MARK: Layout
    /// Sub-model containing layout properties.
    public struct Layout {
        // MARK: Properties
        /// Indicates if the first row has separator before it. Defaults to `true`.
        public var showFirstSeparator: Bool = true
        
        /// Indicates if the last row has separator after it. Defaults to `true`.
        public var showLastSeparator: Bool = true
        
        // MARK: Initializers
        /// Initializes sub-model with default values.
        public init() {}
    }
}
