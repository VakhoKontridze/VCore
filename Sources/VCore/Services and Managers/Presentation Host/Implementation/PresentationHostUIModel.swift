//
//  PresentationHostUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 09.08.23.
//

import SwiftUI

// MARK: - Presentation Host UI Model
/// Model that describes UI.
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct PresentationHostUIModel {
    // MARK: Properties
    /// Indicates if modal allows hit tests. Set to `true`.
    ///
    /// For `false` to have an effect, underlying `SwiftUI` `View` shouldn't have gestures.
    public var allowsHitTests: Bool = true

    /// Keyboard responsiveness strategy. Set to `default`.
    ///
    /// Changing this property after modal is presented may cause unintended behaviors.
    public var keyboardResponsivenessStrategy: KeyboardResponsivenessStrategy? = .default

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
        /// Offsets container by the specified value.
        public static func offset(
            _ offset: CGFloat
        ) -> Self {
            .init(.offset(
                offset: offset
            ))
        }

        /// Offsets container by the keyboard height, plus the specified value.
        ///
        /// Using a positive value (keyboard height + value > keyboard height),
        /// may cause visuals gaps between bottom of the modal and the keyboard.
        /// If dimming view is used, this may cause problems.
        public static func offsetByKeyboardHeight(
            additionalOffset: CGFloat = 0
        ) -> Self {
            .init(.offsetByKeyboardHeight(
                additionalOffset: additionalOffset
            ))
        }

        /// Offsets container to un-obscure first responder view, if needed, plus the specified safe area inset.
        public static func offsetByObscuredSubviewHeight(
            safeAreaInset: CGFloat = 20
        ) -> Self {
            .init(.offsetByObscuredSubviewHeight(
                safeAreaInset: safeAreaInset
            ))
        }

        /// Default instance. Set to `offsetByObscuredSubviewHeight`.
        public static var `default`: Self {
            .offsetByObscuredSubviewHeight()
        }

        // MARK: Storage
        enum Storage {
            case offset(offset: CGFloat)
            case offsetByKeyboardHeight(additionalOffset: CGFloat)
            case offsetByObscuredSubviewHeight(safeAreaInset: CGFloat)
        }
    }
}
