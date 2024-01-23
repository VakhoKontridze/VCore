//
//  TouchSensitiveContainerUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 17.09.23.
//

import SwiftUI

// MARK: - Touch Sensitive Container UI Model
/// Model that describes UI.
@available(tvOS 16.0, *)
public struct TouchSensitiveContainerUIModel {
    // MARK: Properties - Body
    /// Number of taps required to trigger the action. Set to `1`.
    public var tapCount: Int = 1

    // MARK: Properties - Background
    /// Background colors.
    public var backgroundColors: StateColors = {
        let color: Color = {
#if os(iOS) || targetEnvironment(macCatalyst)
            Color(uiColor: .systemBackground)
#elseif os(macOS)
            Color.clear // No other color is available
#elseif os(watchOS)
            Color.clear
#else
            fatalError() // Not supported
#endif
        }()

        let pressedColor: Color = {
#if os(iOS) || targetEnvironment(macCatalyst)
            Color(uiColor: .systemFill)
#elseif os(macOS)
            Color(nsColor: .windowBackgroundColor)
#elseif os(watchOS)
            Color.gray.opacity(0.3)
#else
            fatalError() // Not supported
#endif
        }()

        return StateColors(
            enabled: color,
            pressed: pressedColor,
            disabled: color
        )
    }()

    // MARK: Properties - Content
    /// Content opacities. Set to `1`s.
    public var contentOpacities: StateOpacities = .init(1)

    // MARK: Properties - Transition
    /// Animation delay. Set to `0.05`.
    ///
    /// Can be useful when using `List`s.
    public var animationDelay: TimeInterval = 0.01

    /// Animation. Set to `easeOut` with duration `0.15`.
    public var animation: Animation? = .easeOut(duration: 0.25)

    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}

    // MARK: State Colors
    /// Model that contains colors for component states.
    public typealias StateColors = GenericStateModel_EnabledPressedDisabled<Color>

    /// Model that contains colors for component opacities.
    public typealias StateOpacities = GenericStateModel_EnabledPressedDisabled<CGFloat>
}
