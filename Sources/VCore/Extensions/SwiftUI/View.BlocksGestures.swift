//
//  View.BlocksGestures.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.03.23.
//

import SwiftUI

// MARK: - View Blocks Gestures
extension View {
    /// Overlays clear `Rectangle` that blocks gestures if condition is met.
    ///
    ///     var body: some View {
    ///         Button("Lorem Ipsum", action: doSomething)
    ///             .blockGestures(!isInteractionEnabled)
    ///     }
    ///
    public func blocksGestures(
        _ flag: Bool = true
    ) -> some View {
        self
            .if(flag, transform: {
                $0
                    .overlay(Color.clear.contentShape(Rectangle()))
            })
    }
}
