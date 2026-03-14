//
//  EdgeInsetsVertical.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/1/21.
//

import SwiftUI

/// Edge insets containing `top` and `bottom` values.
@MemberwiseInitializable(
    comment: "/// Initializes `EdgeInsetsVertical` with values."
)
nonisolated public struct EdgeInsetsVertical: Equatable, Hashable, Sendable {
    // MARK: Properties - Base
    /// Top value.
    public var top: CGFloat
    
    /// Bottom inset  value.
    public var bottom: CGFloat
    
    // MARK: Properties - Derived
    /// Sum of `top` and `bottom` values.
    public var verticalSum: CGFloat { top + bottom }
    
    /// Average of `top` and `bottom` values.
    public var verticalAverage: CGFloat { (top + bottom)/2 }
    
    // MARK: Initializers
    /// Initializes `EdgeInsetsVertical` with value.
    public init(
        _ value: CGFloat
    ) {
        self.top = value
        self.bottom = value
    }
    
    /// Initializes `EdgeInsetsVertical` with zero values.
    public init() {
        self.top = 0
        self.bottom = 0
    }

    // MARK: Map
    /// Returns `EdgeInsetsVertical`  containing the results of mapping the given closure over the values.
    public func map(
        _ transform: (CGFloat) throws -> CGFloat
    ) rethrows -> Self {
        .init(
            top: try transform(top),
            bottom: try transform(bottom)
        )
    }

    // MARK: Inset
    /// Insets `EdgeInsetsVertical` by a given value.
    public func insetBy(
        inset: CGFloat
    ) -> EdgeInsetsVertical {
        .init(
            top: top + inset,
            bottom: bottom + inset
        )
    }
    
    /// Insets `EdgeInsetsVertical` by a given top and bottom values.
    public func insetBy(
        top topInset: CGFloat,
        bottom bottomInset: CGFloat
    ) -> EdgeInsetsVertical {
        .init(
            top: top + topInset,
            bottom: bottom + bottomInset
        )
    }
    
    /// Insets `EdgeInsetsVertical` by a given top value.
    public func insetBy(
        top topInset: CGFloat
    ) -> EdgeInsetsVertical {
        .init(
            top: top + topInset,
            bottom: bottom
        )
    }
    
    /// Insets `EdgeInsetsVertical` by a given bottom value.
    public func insetBy(
        bottom bottomInset: CGFloat
    ) -> EdgeInsetsVertical {
        .init(
            top: top,
            bottom: bottom + bottomInset
        )
    }
    
    // MARK: Operators
    /// Adds two `EdgeInsetsVertical` by adding up individual edge insets.
    public static func + (lhs: Self, rhs: Self) -> Self {
        .init(
            top: lhs.top + rhs.top,
            bottom: lhs.bottom + rhs.bottom
        )
    }
    
    /// Adds right `EdgeInsetsVertical` to the left one by adding individual edge insets.
    public static func += (lhs: inout Self, rhs: Self) {
        lhs.top += rhs.top
        lhs.bottom += rhs.bottom
    }
    
    /// Subtracts two `EdgeInsetsVertical` by subtracting up individual edge insets.
    public static func - (lhs: Self, rhs: Self) -> Self {
        .init(
            top: lhs.top - rhs.top,
            bottom: lhs.bottom - rhs.bottom
        )
    }
    
    /// Subtracts right `EdgeInsetsVertical` to the left one by subtracting individual edge insets.
    public static func -= (lhs: inout Self, rhs: Self) {
        lhs.top -= rhs.top
        lhs.bottom -= rhs.bottom
    }
}

nonisolated extension View {
    /// Adds a specific padding amount to each edge of `View` from `EdgeInsetsVertical`.
    ///
    ///     let insets: EdgeInsetsVertical = .init(
    ///         top: 10,
    ///         bottom: 10
    ///     )
    ///
    ///     var body: some View {
    ///         Text("Lorem Ipsum")
    ///             .padding(insets)
    ///     }
    ///
    public func padding(_ insets: EdgeInsetsVertical) -> some View {
        self
            .padding(.top, insets.top)
            .padding(.bottom, insets.bottom)
    }
}
