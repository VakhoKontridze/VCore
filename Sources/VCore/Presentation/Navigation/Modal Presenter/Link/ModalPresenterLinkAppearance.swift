//
//  ModalPresenterLinkAppearance.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11.07.24.
//

import SwiftUI

/// Model that describes appearance.
public struct ModalPresenterLinkAppearance {
    // MARK: Properties - Frame
    /// Alignment of modal in the root.
    public var alignment: Alignment = .center
    
    // MARK: Properties - Dimming View
    /// Preferred dimming color, that overrides a shared color from `ModalPresenterRootAppearance`, when only this modal is presented.
    public var preferredDimmingViewColor: Color?

    // MARK: Properties - Misc
    /// Indicates if modal is dismissed when link disappears.
    public var dismissesModalWhenLinkDisappears: Bool = true

    // MARK: Initializers
    /// Initializes appearance with default values.
    public init() {}
}
