//
//  PlainListAppearance.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 27.11.23.
//

public import SwiftUI

/// Model that describes appearance.
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct PlainListAppearance {
    // MARK: Properties
    /// Row background color.
    public var rowBackgroundColor: Color = .clear

    // MARK: Initializers
    /// Initializes appearance with default values.
    public init() {}
    
    /// Initializes appearance from the given base instance and applies the given configuration.
    public init(
        _ base: Self = .init(),
        _ configure: (inout Self) -> Void
    ) {
        self = base
        configure(&self)
    }
}
