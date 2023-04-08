//
//  View.ShadowWithParameters.swift
//  
//
//  Created by Vakhtang Kontridze on 08.04.23.
//

import SwiftUI

// MARK: - View Shadow with Parameters
extension View {
    /// Adds a shadow to the `View` with parameters.
    public func shadow(parameters: SwiftUIDropShadowParameters) -> some View {
        self
            .shadow(
                color: parameters.color,
                radius: parameters.radius,
                offset: parameters.offset
            )
    }
}

// MARK: - SwiftUI Drop Shadow Parameters
/// Model that can be used to apply shadow to `View`.
public struct SwiftUIDropShadowParameters {
    // MARK: Properties
    /// Shadow color.
    let color: Color
    
    /// Shadow radius.
    let radius: CGFloat
    
    /// Shadow offset.
    let offset: CGPoint
    
    // MARK: Initializers
    /// Initializes `SwiftUIDropShadowParameters` with parameters.
    public init(
        color: Color,
        radius: CGFloat,
        offset: CGPoint
    ) {
        self.color = color
        self.radius = radius
        self.offset = offset
    }
}
