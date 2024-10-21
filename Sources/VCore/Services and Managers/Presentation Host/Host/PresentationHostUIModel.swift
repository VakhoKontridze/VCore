//
//  PresentationHostUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11.07.24.
//

import SwiftUI

// MARK: - Presentation Host UIModel
/// Model that describes UI.
public struct PresentationHostUIModel: Sendable {
    // MARK: Properties
    /// Alignment of modal in the layer. Set to `center`.
    public var alignment: Alignment = .center

    /// Indicates if modal is dismissed when host disappears. Set to `true`.
    public var dismissesModalWhenHostDisappears: Bool = true

    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}
}
