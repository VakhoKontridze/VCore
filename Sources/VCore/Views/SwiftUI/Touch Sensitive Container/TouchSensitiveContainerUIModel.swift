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
public struct TouchSensitiveContainerUIModel: Sendable {
    // MARK: Properties - Body
    /// Indicates if tap is enabled. Set to `true`.
    public var isTapEnabled: Bool = true
    
    /// Number of taps required to trigger the action. Set to `1`.
    public var tapCount: Int = 1

    // MARK: Properties - Background
    /// Background colors.
    public var backgroundColors: StateColors = {
        let color: Color = {
#if os(iOS)
            Color(uiColor: UIColor.systemBackground)
#elseif os(macOS)
            Color.clear
#elseif os(watchOS)
            Color.clear
#elseif os(visionOS)
            Color.clear
#else
            fatalError() // Not supported
#endif
        }()

        let pressedColor: Color = {
#if os(iOS)
            Color(uiColor: UIColor.systemFill)
#elseif os(macOS)
            Color(nsColor: NSColor.windowBackgroundColor)
#elseif os(watchOS)
            Color.gray.opacity(0.3)
#elseif os(visionOS)
            Color(uiColor: UIColor.systemFill)
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
    /// Content opacities. Set to `(1, 1, 1)`.
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
