//
//  PresentationHostUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11.07.24.
//

import SwiftUI

// MARK: - Presentation Host UIModel
/// Model that describes UI.
public struct PresentationHostUIModel {
    // MARK: Properties
    /// Indicates if modal is dismissed when host disappears. Set to `true`.
    public var dismissesModalWhenHostDisappears: Bool = true

    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}
}
