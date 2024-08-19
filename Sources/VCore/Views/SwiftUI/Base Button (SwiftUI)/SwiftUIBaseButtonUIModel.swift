//
//  SwiftUIBaseButtonUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.03.23.
//

import SwiftUI

// MARK: - Swift UI Base Button UI Model
/// Model that describes UI.
public struct SwiftUIBaseButtonUIModel {
    // MARK: Properties
    /// Indicates if button animates state change. Set to `true`.
    ///
    /// Changing this property conditionally will cause view state to be reset.
    public var animatesStateChange: Bool = true
    
    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}
}
