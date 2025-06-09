//
//  ModalPresenterLinkUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11.07.24.
//

import SwiftUI

// MARK: - Modal Presenter Link UI Model
/// Model that describes UI.
public struct ModalPresenterLinkUIModel: Sendable {
    // MARK: Properties - Frame
    /// Alignment of modal in the root. Set to `center`.
    public var alignment: Alignment = .center
    
    // MARK: Properties - Dimming View
    /// Preferred dimming color, that overrides a shared color from `ModalPresenterRootUIModel`, when only this modal is presented.
    public var preferredDimmingViewColor: Color?

    // MARK: Properties - Misc
    /// Indicates if modal is dismissed when link disappears. Set to `true`.
    public var dismissesModalWhenLinkDisappears: Bool = true

    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}
}
