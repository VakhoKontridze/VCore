//
//  PlainListAppearance.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 27.11.23.
//

import SwiftUI

/// Model that describes appearance.
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct PlainListAppearance: Sendable {
    // MARK: Properties
    /// Row background color.
    public var rowBackgroundColor: Color = .clear

    // MARK: Initializers
    /// Initializes appearance with default values.
    public init() {}
}
