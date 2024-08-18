//
//  RectangleCornerRadii+InitWithValues.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 09.07.24.
//

import SwiftUI

// MARK: - Rectangle Corner Radii + Init with Values - Value
extension RectangleCornerRadii {
    /// Initializes `RectangleCornerRadii` with value.
    public init(
        _ value: CGFloat
    ) {
        self.init(
            topLeading: value,
            bottomLeading: value,
            bottomTrailing: value,
            topTrailing: value
        )
    }
}

// MARK: - Rectangle Corner Radii + Init with Values - Horizontal
extension RectangleCornerRadii {
    /// Initializes `RectangleCornerRadii` with leading and trailing values.
    public init(
        leadingCorners: CGFloat,
        trailingCorners: CGFloat
    ) {
        self.init(
            topLeading: leadingCorners,
            bottomLeading: leadingCorners,
            bottomTrailing: trailingCorners,
            topTrailing: trailingCorners
        )
    }

    /// Initializes `RectangleCornerRadii` with leading value.
    public init(
        leadingCorners: CGFloat
    ) {
        self.init(
            topLeading: leadingCorners,
            bottomLeading: leadingCorners
        )
    }

    /// Initializes `RectangleCornerRadii` with trailing value.
    public init(
        trailingCorners: CGFloat
    ) {
        self.init(
            bottomTrailing: trailingCorners,
            topTrailing: trailingCorners
        )
    }
}

// MARK: - Rectangle Corner Radii + Init with Values - Vertical
extension RectangleCornerRadii {
    /// Initializes `RectangleCornerRadii` with top and bottom values.
    public init(
        topCorners: CGFloat,
        bottomCorners: CGFloat
    ) {
        self.init(
            topLeading: topCorners,
            bottomLeading: bottomCorners,
            bottomTrailing: bottomCorners,
            topTrailing: topCorners
        )
    }

    /// Initializes `RectangleCornerRadii` with top value.
    public init(
        topCorners: CGFloat
    ) {
        self.init(
            topLeading: topCorners,
            topTrailing: topCorners
        )
    }

    /// Initializes `RectangleCornerRadii` with bottom value.
    public init(
        bottomCorners: CGFloat
    ) {
        self.init(
            bottomLeading: bottomCorners,
            bottomTrailing: bottomCorners
        )
    }
}
