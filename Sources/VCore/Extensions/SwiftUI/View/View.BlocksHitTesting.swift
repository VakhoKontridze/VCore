//
//  View.BlocksHitTesting.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.03.23.
//

import SwiftUI

// MARK: - View Blocks Hit Testing
extension View {
    /// Overlays clear `Rectangle` that blocks gestures if condition is met.
    ///
    ///     var body: some View {
    ///         Button("Lorem Ipsum", action: doSomething)
    ///             .blocksHitTesting(!isInteractionEnabled)
    ///     }
    ///
    public func blocksHitTesting(
        _ flag: Bool = true
    ) -> some View {
        self
            .overlay(content: {
                if flag {
                    Color.clear.contentShape(Rectangle())
                }
            })
    }
}
