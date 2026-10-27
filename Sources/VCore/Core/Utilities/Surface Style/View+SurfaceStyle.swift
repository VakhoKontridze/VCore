//
//  View+SurfaceStyle.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 27/10/26.
//

public import SwiftUI

nonisolated extension View {
    /// Draws `SurfaceStyle` behind the `View`, within shape.
    ///
    /// Content is not clipped to shape.
    ///
    ///     var body: some View {
    ///         Text("Lorem ipsum")
    ///             .padding()
    ///             .surfaceStyle(.color(Color.blue), in: .capsule)
    ///     }
    ///
    @ViewBuilder
    public func surfaceStyle(
        _ surfaceStyle: SurfaceStyle,
        in shape: some Shape
    ) -> some View {
        switch surfaceStyle.storage {
        case .color(let color):
            self
                .background(color, in: shape)

#if os(visionOS)
        case .glass:
            self // Unreachable, as `glass(_:)` is unavailable on `visionOS`
#else
        case .glass(let configuration):
            if #available(anyAppleOS 26.0, *) {
                self
                    .glassEffect(configuration.glass, in: shape)
            } else {
                self // Unreachable, as `glass(_:)` requires `anyAppleOS 26.0`
            }
#endif
        }
    }
}
