//
//  View.OverlayGestureBlocker.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.03.23.
//

import SwiftUI

// MARK: - View Overlay Gesture Blocker
extension View {
    /// Overlays clear `Rectangle` that blocks gestures if condition is met.
    ///
    ///     var body: some View {
    ///         Button("Lorem Ipsum", action: doSomething)
    ///             .overlayGestureBlocker(if: !isInteractionEnabled)
    ///     }
    ///
    public func overlayGestureBlocker(
        if condition: Bool = true
    ) -> some View {
        self
            .if(condition, transform: {
                $0
                    .overlay(Color.clear.contentShape(Rectangle()))
            })
    }
}
