//
//  View.CornerRadiusWithCustomCorners_RectCorner.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21.03.23.
//

import SwiftUI

// MARK: - Corner Radius with Custom Corners
extension View {
    /// Clips this `View` to its bounding frame, with the specified corners and corner radius.
    ///
    ///     Color.accentColor
    ///         .frame(dimension: 100)
    ///         .cornerRadius(10, corners: .allCorners)
    ///
    public func cornerRadius(
        _ radius: CGFloat,
        corners: RectCorner
    ) -> some View {
        self
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

// MARK: - Corner Radius Shape
private struct CornerRadiusShape: Shape {
    // MARK: Properties
    private let radius: CGFloat
    private let corners: RectCorner

    // MARK: Initializers
    init(radius: CGFloat, corners: RectCorner) {
        self.radius = radius
        self.corners = corners
    }

    // MARK: Shape
    func path(in rect: CGRect) -> Path {
        var path: Path = .init()

        path.move(to: .init(
            x: rect.minX,
            y: corners.contains(.topLeft) ? rect.minY + radius : rect.minY
        ))
        
        path.addArc(
            tangent1End: .init(
                x: rect.minX,
                y: rect.minY
            ),
            tangent2End: .init(
                x: corners.contains(.topLeft) ? rect.minX + radius : rect.minX,
                y: rect.minY
            ),
            radius: radius
        )
        
        path.addLine(to: .init(
            x: corners.contains(.topRight) ? rect.maxX - radius : rect.maxX,
            y: rect.minY
        ))
        
        path.addArc(
            tangent1End: .init(
                x: rect.maxX,
                y: rect.minY
            ),
            tangent2End: .init(
                x: rect.maxX,
                y: corners.contains(.topRight) ? rect.minY + radius  : rect.minY
            ),
            radius: radius
        )
        
        path.addLine(to: .init(
            x: rect.maxX,
            y: corners.contains(.bottomRight) ? rect.maxY - radius : rect.maxY
        ))
        
        path.addArc(
            tangent1End: .init(
                x: rect.maxX,
                y: rect.maxY
            ),
            tangent2End: .init(
                x: corners.contains(.bottomRight) ? rect.maxX - radius : rect.maxX,
                y: rect.maxY
            ),
            radius: radius
        )
        
        path.addLine(to: .init(
            x: corners.contains(.bottomLeft) ? rect.minX + radius : rect.minX,
            y: rect.maxY
        ))
        
        path.addArc(
            tangent1End: .init(
                x: rect.minX,
                y: rect.maxY
            ),
            tangent2End: .init(
                x: rect.minX,
                y: corners.contains(.bottomLeft) ? rect.maxY - radius : rect.maxY
            ),
            radius: radius
        )
        
        path.closeSubpath()

        return path
    }
}