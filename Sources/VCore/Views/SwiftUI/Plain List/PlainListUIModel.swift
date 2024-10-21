//
//  PlainListUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 27.11.23.
//

import SwiftUI

// MARK: - Plain List UI Model
/// Model that describes UI.
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct PlainListUIModel: Sendable {
    // MARK: Properties
    /// Row background color.
    public var rowBackgroundColor: Color = .clear

    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}
}
