//
//  EdgeInsets_LB.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/1/21.
//

import UIKit

// MARK: - Edge Insets (Top, Bottom)
/// Edge insets containing `top` and `bottom` values.
public struct EdgeInsets_TB: Equatable {
    // MARK: Properties
    /// Top inset value.
    public var top: CGFloat
    
    /// Bottom inset  value.
    public var bottom: CGFloat
    
    // MARK: Initializers
    /// Initializes insets with values.
    public init(top: CGFloat, bottom: CGFloat) {
        self.top = top
        self.bottom = bottom
    }
    
    /// Initializes insets with zero values.
    public init() {
        self.top = 0
        self.bottom = 0
    }
    
    /// Initializes insets with zero values.
    public static var zero: Self { .init() }
}