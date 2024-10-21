//
//  KeyboardObserverUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.07.24.
//

import SwiftUI

// MARK: - Keyboard Observer UI Model
/// Model that describes UI.
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
public struct KeyboardObserverUIModel: Sendable {
    // MARK: Properties
    /// Keyboard responsiveness strategy. Set to `default`.
    ///
    /// Changing this property conditionally will cause view state to be reset.
    public var keyboardResponsivenessStrategy: KeyboardResponsivenessStrategy = .default

    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}

    // MARK: Keyboard Responsiveness Strategy
    /// Keyboard responsiveness strategy.
    public enum KeyboardResponsivenessStrategy: Sendable {
        // MARK: Cases
        /// None.
        case `none`

        /// Offsets container by the specified value.
        case offset(offset: CGFloat)

        /// Offsets container by the keyboard height, plus the specified value.
        ///
        /// Using a positive value (`keyboard height + value > keyboard height`)
        /// may cause visuals gaps between bottom of the modal and the keyboard.
        case offsetByKeyboardHeight(additionalOffset: CGFloat)

        /// Offsets container to un-obscure first responder view, if needed.
        case offsetByObscuredViewHeight(additionalOffset: CGFloat)

        // MARK: Initializers
        /// Default instance. Set to `offsetByObscuredViewHeight`.
        public static var `default`: Self {
            .offsetByObscuredViewHeight(
                additionalOffset: 20
            )
        }
    }
}
