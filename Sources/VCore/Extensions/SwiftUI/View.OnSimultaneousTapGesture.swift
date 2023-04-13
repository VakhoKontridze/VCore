//
//  View.OnSimultaneousTapGesture.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.04.23.
//

import SwiftUI

// MARK: - View
@available(tvOS 16.0, *)
extension View {
    /// Adds an action to perform when this view recognizes a simultaneous tap gesture
    /// with gestures defined by the `View`.
    ///
    ///     var body: some View {
    ///         SomeViewWithExistingGestures()
    ///             .onSimultaneousTapGesture(perform: doSomethingElseAsWell)
    ///     }
    ///
    public func onSimultaneousTapGesture(
        count: Int = 1,
        perform action: @escaping () -> Void
    ) -> some View {
        self
            .simultaneousGesture(TapGesture(count: count).onEnded(action))
    }
}
