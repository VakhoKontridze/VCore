//
//  View.CornerRadiusWithCustomCorners_UIRectCorner.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/28/21.
//

#if canImport(UIKit)

import SwiftUI

// MARK: - View Corner Radius with Custom Corners
extension View {
    /// Clips `View` to its bounding frame, with the specified corners and corner radius.
    ///
    ///     Color.accentColor
    ///         .frame(dimension: 100)
    ///         .cornerRadius(10, corners: .allCorners)
    ///
    public func cornerRadius( // TODO: iOS 16 - Remove. Obsoleted by `clipShape(.rect(...))` and `UnevenRoundedRectangle`.
        _ radius: CGFloat,
        uiCorners corners: UIRectCorner
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
            cornerRadii: CGSize(dimension: radius)
        ).cgPath)
    }
}

#endif
