//
//  View+ShadowWithParameters.swift
//  
//  VCore
//  Created by Vakhtang Kontridze on 08.04.23.
//

import SwiftUI

// MARK: - View + Shadow with Parameters
extension View {
    /// Adds a shadow to the `View` with parameters.
    ///
    ///     let parameters: SwiftUIDropShadowParameters = .init(
    ///         color: Color.black.opacity(0.3),
    ///         radius: 10,
    ///         offset: CGPoint(x: 0, y: 10)
    ///     )
    ///
    ///     someView
    ///         .shadow(parameters: parameters)
    ///
    public func shadow(parameters: SwiftUIDropShadowParameters) -> some View {
        self
            .shadow(
                color: parameters.color,
                radius: parameters.radius,
                offset: parameters.offset
            )
    }
}

// MARK: - Swift UI Drop Shadow Parameters
/// Model that can be used to apply shadow to `View`.
@MemberwiseInitializable(
    comment: "/// Initializes `SwiftUIDropShadowParameters` with parameters."
)
public struct SwiftUIDropShadowParameters: Sendable {
    /// Shadow color.
    let color: Color
    
    /// Shadow radius.
    let radius: CGFloat
    
    /// Shadow offset.
    let offset: CGPoint
}
