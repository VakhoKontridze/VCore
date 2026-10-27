//
//  GenericStateSurfaceStyle.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 27/10/26.
//

public import SwiftUI

/// Style of a surface drawn behind a `View`, either a solid `Color` or Liquid Glass, with state-bound colors.
///
/// `Colors` is a `GenericStateModel` of `Color`s, such as `GenericStateModel_EnabledPressedDisabled<Color>`.
/// Applied with `surfaceStyle(_:state:in:)`, which resolves colors for the given state.
///
///     typealias StateColors = GenericStateModel_EnabledPressedDisabled<Color>
///
///     let style: GenericStateSurfaceStyle<StateColors> = .color(
///         StateColors(
///             enabled: Color.blue,
///             pressed: Color.blue.opacity(0.75),
///             disabled: Color.gray
///         )
///     )
///
///     var body: some View {
///         Text("Lorem ipsum")
///             .padding()
///             .surfaceStyle(style, state: .enabled, in: .capsule)
///     }
///
/// Liquid Glass requires `anyAppleOS 26.0`, and is unavailable on `visionOS`.
/// Its tint colors are state-bound as well.
///
///     if #available(anyAppleOS 26.0, *) {
///         style = .glass(
///             .regular
///                 .tint(StateColors(Color.blue))
///                 .interactive()
///         )
///     }
///
nonisolated public struct GenericStateSurfaceStyle<Colors> {
    // MARK: Properties
    let storage: Storage

    /// Colors of a solid `Color` surface, or tint colors of a Liquid Glass surface.
    public var colors: Colors? {
        switch storage {
        case .color(let colors): colors
        case .glass(let configuration): configuration.tintColors
        }
    }

    // MARK: Initializers
    init(
        _ storage: Storage
    ) {
        self.storage = storage
    }

    /// Solid `Color` surface.
    public static func color(
        _ colors: Colors
    ) -> Self {
        .init(
            .color(
                colors: colors
            )
        )
    }

    /// Liquid Glass surface.
    @available(anyAppleOS 26.0, *)
    @available(visionOS, unavailable)
    public static func glass(
        _ configuration: GlassConfiguration = .regular
    ) -> Self {
        .init(
            .glass(
                configuration: configuration
            )
        )
    }

    // MARK: Mapping
    /// Maps `GenericStateSurfaceStyle` to `SurfaceStyle`, resolving `Colors` to a `Color` with the given closure.
    public func toSurfaceStyle(
        resolveColor: (Colors) -> Color
    ) -> SurfaceStyle {
        switch storage {
        case .color(let colors):
            SurfaceStyle(
                .color(
                    color: resolveColor(colors)
                )
            )

        case .glass(let configuration):
            SurfaceStyle(
                .glass(
                    configuration: SurfaceStyle.GlassConfiguration(
                        variant: configuration.variant,
                        tintColor: configuration.tintColors.map { resolveColor($0) },
                        isInteractive: configuration.isInteractive
                    )
                )
            )
        }
    }

    // MARK: Types
    nonisolated enum Storage {
        case color(colors: Colors)
        case glass(configuration: GlassConfiguration)
    }

    /// Configuration of a Liquid Glass surface, with state-bound tint colors.
    nonisolated public struct GlassConfiguration {
        // MARK: Properties
        var variant: SurfaceStyle.GlassConfiguration.Variant
        var tintColors: Colors?
        var isInteractive: Bool

        // MARK: Initializers
        init(
            variant: SurfaceStyle.GlassConfiguration.Variant,
            tintColors: Colors?,
            isInteractive: Bool
        ) {
            self.variant = variant
            self.tintColors = tintColors
            self.isInteractive = isInteractive
        }

        /// Regular glass.
        public static var regular: Self {
            .init(
                variant: .regular,
                tintColors: nil,
                isInteractive: false
            )
        }

        /// Clear glass.
        ///
        /// Content should remain legible by adding a dimming layer beneath the glass.
        public static var clear: Self {
            .init(
                variant: .clear,
                tintColors: nil,
                isInteractive: false
            )
        }

        // MARK: Configuration
        /// Returns copy tinted with state-bound `Colors`.
        public func tint(
            _ colors: Colors?
        ) -> Self {
            var copy: Self = self
            copy.tintColors = colors
            return copy
        }

        /// Returns copy that reacts to touch and pointer interactions.
        public func interactive(
            _ isInteractive: Bool = true
        ) -> Self {
            var copy: Self = self
            copy.isInteractive = isInteractive
            return copy
        }
    }
}

nonisolated extension GenericStateSurfaceStyle: Equatable where Colors: Equatable {}

nonisolated extension GenericStateSurfaceStyle: Hashable where Colors: Hashable {}

nonisolated extension GenericStateSurfaceStyle: Sendable where Colors: Sendable {}

nonisolated extension GenericStateSurfaceStyle.Storage: Equatable where Colors: Equatable {}

nonisolated extension GenericStateSurfaceStyle.Storage: Hashable where Colors: Hashable {}

nonisolated extension GenericStateSurfaceStyle.Storage: Sendable where Colors: Sendable {}

nonisolated extension GenericStateSurfaceStyle.GlassConfiguration: Equatable where Colors: Equatable {}

nonisolated extension GenericStateSurfaceStyle.GlassConfiguration: Hashable where Colors: Hashable {}

nonisolated extension GenericStateSurfaceStyle.GlassConfiguration: Sendable where Colors: Sendable {}
