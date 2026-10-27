//
//  View+GenericStateSurfaceStyle+EnabledPressedLoadingDisabled.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 27/10/26.
//

public import SwiftUI

nonisolated extension View {
    /// Draws `GenericStateSurfaceStyle` behind the `View`, within shape, with colors resolved for state.
    ///
    /// Content is not clipped to shape.
    ///
    ///     let style: GenericStateSurfaceStyle<GenericStateModel_EnabledPressedLoadingDisabled<Color>> = ...
    ///     let state: GenericState_EnabledPressedLoadingDisabled = ...
    ///
    ///     var body: some View {
    ///         contentView
    ///             .surfaceStyle(style, state: state, in: .capsule)
    ///     }
    ///
    public func surfaceStyle(
        _ surfaceStyle: GenericStateSurfaceStyle<
            GenericStateModel_EnabledPressedLoadingDisabled<Color>
        >,
        state: GenericState_EnabledPressedLoadingDisabled,
        in shape: some Shape
    ) -> some View {
        self
            .surfaceStyle(
                surfaceStyle.toSurfaceStyle(resolveColor: { $0.value(for: state) }),
                in: shape
            )
    }
}
