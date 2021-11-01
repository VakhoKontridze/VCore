//
//  EdgeInsets_LT.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/1/21.
//

import UIKit

// MARK: - Edge Insets (Leading, Trailing)
/// Edge insets containing `leading` and `trailing` values.
public struct EdgeInsets_LT: Equatable {
    // MARK: Properties
    /// Leading inset value.
    public var leading: CGFloat
    
    /// Trailing inset value.
    public var trailing: CGFloat
    
    // MARK: Initializers
    /// Initializes group with values.
    public init(leading: CGFloat, trailing: CGFloat) {
        self.leading = leading
        self.trailing = trailing
    }
    
    /// Initializes insets with zero values.
    public init() {
        self.init(
            leading: 0,
            trailing: 0
        )
    }
    
    /// Initializes insets with zero values.
    public static var zero: Self {
        .init()
    }
    
    // MARK: Equatable
    public static func ==(lhs: EdgeInsets_LT, rhs: EdgeInsets_LT) -> Bool {
        (lhs.leading, lhs.trailing) == (rhs.leading, rhs.trailing)
    }
}
