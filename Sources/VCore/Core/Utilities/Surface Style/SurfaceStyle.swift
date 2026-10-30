//
//  SurfaceStyle.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 27/10/26.
//

public import SwiftUI

/// Style of a surface drawn behind a `View`, either a solid `Color` or Liquid Glass.
///
/// Applied with `surfaceStyle(_:in:)`.
/// For a surface with state-bound colors, refer to `GenericStateSurfaceStyle`.
///
///     var body: some View {
///         Text("Lorem ipsum")
///             .padding()
///             .surfaceStyle(.color(Color.blue), in: .capsule)
///     }
///
/// Liquid Glass requires `anyAppleOS 26.0`, and is unavailable on `visionOS`.
///
///     var body: some View {
///         if #available(anyAppleOS 26.0, *) {
///             Text("Lorem ipsum")
///                 .padding()
///                 .surfaceStyle(.glass(.regular.tint(Color.blue).interactive()), in: .capsule)
///         }
///     }
///
nonisolated public struct SurfaceStyle: Equatable, Hashable, Sendable {
    // MARK: Properties
    let storage: Storage

    /// Indicates if surface is Liquid Glass.
    ///
    /// A Liquid Glass surface renders the content behind it, so a modifier that composites offscreen, such as `compositingGroup()`, should be skipped for it.
    public var isGlass: Bool {
        switch storage {
        case .color: false
        case .glass: true
        }
    }

    /// Color of a solid `Color` surface, or tint color of a Liquid Glass surface.
    public var color: Color? {
        switch storage {
        case .color(let color): color
        case .glass(let configuration): configuration.tintColor
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
        _ color: Color
    ) -> Self {
        .init(
            .color(
                color: color
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

    // MARK: Types
    nonisolated enum Storage: Equatable, Hashable, Sendable {
        case color(color: Color)
        case glass(configuration: GlassConfiguration)
    }

    /// Configuration of a Liquid Glass surface.
    nonisolated public struct GlassConfiguration: Equatable, Hashable, Sendable {
        // MARK: Properties
        var variant: Variant
        var tintColor: Color?
        var isInteractive: Bool

        // MARK: Initializers
        init(
            variant: Variant,
            tintColor: Color?,
            isInteractive: Bool
        ) {
            self.variant = variant
            self.tintColor = tintColor
            self.isInteractive = isInteractive
        }

        /// Regular glass.
        public static let regular: Self = .init(
            variant: .regular,
            tintColor: nil,
            isInteractive: false
        )

        /// Clear glass.
        ///
        /// Content should remain legible by adding a dimming layer beneath the glass.
        public static let clear: Self = .init(
            variant: .clear,
            tintColor: nil,
            isInteractive: false
        )

        // MARK: Configuration
        /// Returns copy tinted with `Color`.
        public func tint(
            _ color: Color?
        ) -> Self {
            var copy: Self = self
            copy.tintColor = color
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

        // MARK: Mapping
        @available(anyAppleOS 26.0, *)
        @available(visionOS, unavailable)
        var glass: Glass {
            let base: Glass = {
                switch variant {
                case .regular: .regular
                case .clear: .clear
                }
            }()

            return base
                .tint(tintColor)
                .interactive(isInteractive)
        }

        // MARK: Types
        nonisolated enum Variant: Equatable, Hashable, Sendable {
            case regular
            case clear
        }
    }
}
