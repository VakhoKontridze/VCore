//
//  SwiftUIBaseButtonAppearance.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.03.23.
//

import SwiftUI

/// Model that describes appearance.
public struct SwiftUIBaseButtonAppearance {
    // MARK: Properties
    /// Indicates if button animates state change.
    ///
    /// Changing this property conditionally will cause view state to be reset.
    public var animatesStateChange: Bool = true
    
    // MARK: Initializers
    /// Initializes appearance with default values.
    public init() {}
    
    /// Initializes appearance from the base instance and applies transformation.
    public init(
        _ base: Self = .init(),
        _ transform: (inout Self) -> Void
    ) {
        self = base
        transform(&self)
    }
}
