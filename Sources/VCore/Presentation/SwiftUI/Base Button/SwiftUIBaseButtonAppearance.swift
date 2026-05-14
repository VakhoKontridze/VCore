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
}
