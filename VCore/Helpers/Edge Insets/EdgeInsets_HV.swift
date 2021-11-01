//
//  EdgeInsets_HV.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/1/21.
//

import UIKit

// MARK: - Edge Insets (Horizontal, Vertical)
/// Edge insets containing `horizontal` and `vertical` values.
public struct EdgeInsets_HV: Equatable {
    // MARK: Properties
    /// Horizontal inset value.
    public var horizontal: CGFloat
    
    /// Vertical inset  value.
    public var vertical: CGFloat
    
    // MARK: Initializers
    /// Initializes insets with values.
    public init(horizontal: CGFloat, vertical: CGFloat) {
        self.horizontal = horizontal
        self.vertical = vertical
    }
    
    /// Initializes insets with zero values.
    public init() {
        self.init(
            horizontal: 0,
            vertical: 0
        )
    }
    
    /// Initializes insets with zero values.
    public static var zero: Self {
        .init()
    }
}
