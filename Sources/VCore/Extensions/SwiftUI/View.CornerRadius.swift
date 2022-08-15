//
//  View.CornerRadius.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/28/21.
//

#if canImport(UIKit)

import SwiftUI
import UIKit

// MARK: - Corner Radius
extension View {
    /// Clips this `View` to its bounding frame, with the specified corners and corner radius.
    ///
    ///     Color.accentColor
    ///         .frame(dimension: 100)
    ///         .cornerRadius(10, corners: .allCorners)
    ///
    public func cornerRadius(
        _ radius: CGFloat,
        corners: UIRectCorner,
        style: RoundedCornerStyle = .circular
    ) -> some View {
        self
            .clipShape(CornerRadiusShape(
                radius: radius,
                corners: corners,
                style: style
            ))
    }
}

// MARK: - Corner Radius Shape
private struct CornerRadiusShape: Shape {
    // MARK: Properties
    private let radius: CGFloat
    private let corners: UIRectCorner
    private let style: RoundedCornerStyle
    
    // MARK: Initializers
    init(
        radius: CGFloat,
        corners: UIRectCorner,
        style: RoundedCornerStyle
    ) {
        self.radius = radius
        self.corners = corners
        self.style = style
    }

    // MARK: Shape
    func path(in rect: CGRect) -> Path {
        .init(
            roundedRect: rect,
            cornerRadius: radius,
            style: style
        )
    }
}

#endif
