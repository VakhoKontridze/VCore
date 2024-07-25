//
//  KeyboardObserverUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.07.24.
//

#if canImport(UIKit) && !os(watchOS)

import SwiftUI

// MARK: - Keyboard Observer UI Model
/// Model that describes UI.
@available(tvOS, unavailable)
public struct KeyboardObserverUIModel {
    // MARK: Properties
    /// Keyboard responsiveness strategy. Set to `default`.
    ///
    /// Changing this property conditionally will cause view state to be reset.
    public var keyboardResponsivenessStrategy: KeyboardResponsivenessStrategy = .default

    /// Appear animation debounce delay. Set to `0.1`.
    ///
    /// System might call keyboard lifecycle methods in quick succession, which can result in janky animation.
    /// This property debounces a scheduled animation, and retrieves updated parameters, if needed.
    public var appearAnimationDebounceDelay: TimeInterval = 0.1

    /// Disappear animation debounce delay. Set to `0`.
    ///
    /// System might call keyboard lifecycle methods in quick succession, which can result in janky animation.
    /// This property debounces a scheduled animation, and retrieves updated parameters, if needed.
    public var disappearAnimationDebounceDelay: TimeInterval = 0

    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}

    // MARK: Keyboard Responsiveness Strategy
    /// Keyboard responsiveness strategy.
    public struct KeyboardResponsivenessStrategy {
        // MARK: Properties
        let storage: Storage

        // MARK: Initializers
        init(
            _ storage: Storage
        ) {
            self.storage = storage
        }

        // MARK: Initializers
        /// None.
        public static var none: Self {
            .init(
                .none
            )
        }

        /// Offsets container by the specified value.
        public static func offset(
            _ offset: CGFloat
        ) -> Self {
            .init(
                .offset(
                    offset: offset
                )
            )
        }

        /// Offsets container by the keyboard height, plus the specified value.
        ///
        /// Using a positive value (`keyboard height + value > keyboard height`)
        /// may cause visuals gaps between bottom of the modal and the keyboard.
        public static func offsetByKeyboardHeight(
            additionalOffset: CGFloat
        ) -> Self {
            .init(
                .offsetByKeyboardHeight(
                    additionalOffset: additionalOffset
                )
            )
        }

        /// Offsets container to un-obscure first responder view, if needed.
        public static func offsetByObscuredSubviewHeight(
            additionalOffset: CGFloat
        ) -> Self {
            .init(
                .offsetByObscuredSubviewHeight(
                    additionalOffset: additionalOffset
                )
            )
        }

        /// Default instance. Set to `offsetByObscuredSubviewHeight`.
        public static var `default`: Self {
            .offsetByObscuredSubviewHeight(
                additionalOffset: 20
            )
        }

        // MARK: Storage
        enum Storage {
            case none
            case offset(offset: CGFloat)
            case offsetByKeyboardHeight(additionalOffset: CGFloat)
            case offsetByObscuredSubviewHeight(additionalOffset: CGFloat)
        }
    }
}

#endif
