//
//  TouchSensitiveContainerUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 17.09.23.
//

import SwiftUI

// MARK: - Touch Sensitive Container UI Model
/// Model that describes UI.
@available(tvOS, unavailable)
public struct TouchSensitiveContainerUIModel {
    // MARK: Properties - Background
    /// Background colors.
    public var backgroundColors: StateColors = .init(
        enabled: .clear,
        pressed: {
#if os(iOS) || targetEnvironment(macCatalyst)
            return Color(uiColor: .systemFill)
#elseif os(macOS)
            return Color(nsColor: NSColor.windowBackgroundColor)
#elseif os(watchOS)
            return Color.gray.opacity(0.3)
#else
            fatalError() // Not supported
#endif
        }(),
        disabled: .clear
    )

    // MARK: Properties - Content
    /// Content opacities. Set to `1`s.
    public var contentOpacities: StateOpacities = .init(1)

    // MARK: Properties - Transition
    /// Touch down animation. Set to `nil`.
    public var touchDownAnimation: Animation? = nil

    /// Touch up animation. Set to `easeOut` with duration `0.15`.
    public var touchUpAnimation: Animation? = .easeOut(duration: 0.15)

    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}

    // MARK: State Colors
    /// Model that contains colors for component states.
    public typealias StateColors = GenericStateModel_EnabledPressedDisabled<Color>

    /// Model that contains colors for component opacities.
    public typealias StateOpacities = GenericStateModel_EnabledPressedDisabled<CGFloat>
}
