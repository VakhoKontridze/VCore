//
//  View.CornerRadius.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 10/28/21.
//

#if canImport(UIRectCorner)

import SwiftUI

// MARK: - Corner Radius
extension View {
    /// Clips this view to its bounding frame, with the specified corners and corner radius.
    ///
    /// Usage Example:
    ///
    ///     Color.accentColor
    ///         .frame(dimension: 100)
    ///         .cornerRadius(10, corners: .allCorners)
    ///
    public func cornerRadius(
        _ radius: CGFloat,
        corners: UIRectCorner
    ) -> some View {
        self
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

// MARK: - Corner Radius Shape
private struct CornerRadiusShape: Shape {
    // MARK: Properties
    private let radius: CGFloat
    private let corners: UIRectCorner
    
    // MARK: Initializers
    init(radius: CGFloat, corners: UIRectCorner) {
        self.radius = radius
        self.corners = corners
    }

    // MARK: Shape
    func path(in rect: CGRect) -> Path {
        .init(UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: .init(width: radius, height: radius)
        ).cgPath)
    }
}

#endif
