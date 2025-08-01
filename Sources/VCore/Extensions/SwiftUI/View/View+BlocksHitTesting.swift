//
//  View+BlocksHitTesting.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.03.23.
//

import SwiftUI

extension View {
    /// Overlays clear `Rectangle` that blocks gestures if condition is met.
    ///
    ///     var body: some View {
    ///         Button("Lorem Ipsum") {
    ///             ....
    ///         }
    ///         .blocksHitTesting(!isInteractionEnabled)
    ///     }
    ///
    public func blocksHitTesting<S>(
        _ flag: Bool = true,
        shape: S = .rect
    ) -> some View
        where S: Shape
    {
        self
            .overlay {
                if flag {
                    Color.clear
                        .contentShape(shape)
                }
            }
    }
}

#if DEBUG

#Preview {
    Button("Press") {}
        .blocksHitTesting()
}

#endif
