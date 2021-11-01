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
    
    /// Bottom inset  value.
    public var bottom: CGFloat
    
    // MARK: Initializers
    /// Initializes insets with values.
    public init(leading: CGFloat, trailing: CGFloat, top: CGFloat, bottom: CGFloat) {
        self.leading = leading
        self.trailing = trailing
        self.top = top
        self.bottom = bottom
    }
    
    /// Initializes insets with zero values.
    public init() {
        self.init(
            leading: 0,
            trailing: 0,
            top: 0,
            bottom: 0
        )
    }
    
    /// Initializes insets with zero values.
    public static var zero: Self {
        .init()
    }
    
    // MARK: Equatable
    public static func ==(lhs: EdgeInsets_LTTB, rhs: EdgeInsets_LTTB) -> Bool {
        (lhs.leading, lhs.trailing, lhs.top, lhs.bottom) == (rhs.leading, rhs.trailing, rhs.top, rhs.bottom)
    }
}
