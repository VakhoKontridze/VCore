//
//  View.OnSimultaneousTapGesture.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.04.23.
//

import SwiftUI

// MARK: - View Simultaneous Tap Gesture
extension View {
    /// Attaches a gesture to the `View` to process simultaneously with tap gesture defined by the `View`.
    ///
    ///     var body: some View {
    ///         SomeViewWithExistingGestures()
    ///             .onSimultaneousTapGesture(perform: { ... })
    ///     }
    ///
    public func onSimultaneousTapGesture(
        count: Int = 1,
        perform action: @escaping () -> Void
    ) -> some View {
        self
            .simultaneousGesture(
                TapGesture(count: count)
                    .onEnded(action)
            )
    }
}
