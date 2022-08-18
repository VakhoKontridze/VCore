//
//  View.Shadow.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 18.08.22.
//

import SwiftUI

// MARK: - View Shadow
extension View {
    /// Adds a shadow to this view.
    ///
    ///     someView
    ///         .shadow(
    ///             color: .black.opacity(0.3),
    ///             radius: 10,
    ///             offset: .init(x: 0, y: 10)
    ///         )
    ///
    public func shadow(
        color: Color = Color(.sRGBLinear, white: 0, opacity: 0.33),
        radius: CGFloat,
        offset: CGPoint
    ) -> some View {
        self
            .shadow(
                color: color,
                radius: radius,
                x: offset.x,
                y: offset.y
            )
    }
}
