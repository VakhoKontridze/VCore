//
//  EdgeInsets_LTTB.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/1/21.
//

import UIKit

// MARK: - Edge Insets (Leading, Trailing, Top, Bottom)
/// Edge insets containing `leading`, `trailing`, `top` and `bottom` values.
public struct EdgeInsets_LTTB: Equatable {
    // MARK: Properties
    /// Leading inset value.
    public var leading: CGFloat
    
    /// Trailing inset value.
    public var trailing: CGFloat
    
    /// Top inset value.
    public var top: CGFloat
    
    /// Bottom inset value.
    public var bottom: CGFloat
    
    /// Horizontal inset value, that's a sum of `leading` and `trailing` values.
    public var horizontal: CGFloat { leading + trailing }
    
    /// Vertical inset value, that's a sum of `top` and `bottom` values.
    public var vertical: CGFloat { top + bottom }
    
    // MARK: Initializers
    /// Initializes insets with values.
    public init(
        leading: CGFloat,
        trailing: CGFloat,
        top: CGFloat,
        bottom: CGFloat
    ) {
        self.leading = leading
        self.trailing = trailing
        self.top = top
        self.bottom = bottom
    }
    
    /// Initializes insets with value.
    public init(
        _ value: CGFloat
    ) {
        self.leading = value
        self.trailing = value
        self.top = value
        self.bottom = value
    }
    
    /// Initializes insets with horizontal and vertical values.
    public init(
        horizontal: CGFloat,
        vertical: CGFloat
    ) {
        self.leading = horizontal
        self.trailing = horizontal
        self.top = vertical
        self.bottom = vertical
    }
    
    /// Initializes insets with zero values.
    public init() {
        self.leading = 0
        self.trailing = 0
        self.top = 0
        self.bottom = 0
    }
    
    /// Initializes insets with zero values.
    public static var zero: Self { .init() }
}
