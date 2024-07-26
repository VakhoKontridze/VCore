//
//  EdgeInsets_TopBottom.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/1/21.
//

import SwiftUI

// MARK: - Edge Insets (Top, Bottom)
/// Edge insets containing `top` and `bottom` values.
@MemberwiseInitializable(
    comment: "/// Initializes `EdgeInsets_TopBottom` with values."
)
public struct EdgeInsets_TopBottom: Equatable, Hashable {
    // MARK: Properties
    /// Top value.
    public var top: CGFloat
    
    /// Bottom inset  value.
    public var bottom: CGFloat
    
    /// Sum of `top` and `bottom` values.
    public var verticalSum: CGFloat { top + bottom }
    
    /// Average of `top` and `bottom` values.
    public var verticalAverage: CGFloat { (top + bottom)/2 }
    
    // MARK: Initializers
    /// Initializes `EdgeInsets_TopBottom` with value.
    public init(
        _ value: CGFloat
    ) {
        self.top = value
        self.bottom = value
    }
    
    /// Initializes `EdgeInsets_TopBottom` with zero values.
    public init() {
        self.top = 0
        self.bottom = 0
    }
    
    /// Initializes `EdgeInsets_TB` with zero values.
    public static var zero: Self { .init() }

    // MARK: Map
    /// Returns `EdgeInsets_TopBottom`  containing the results of mapping the given closure over the values.
    public func map(
        _ transform: (CGFloat) throws -> CGFloat
    ) rethrows -> Self {
        .init(
            top: try transform(top),
            bottom: try transform(bottom)
        )
    }

    // MARK: Inset
    /// Insets `EdgeInsets_TopBottom` by a given value.
    public func insetBy(
        inset: CGFloat
    ) -> EdgeInsets_TopBottom {
        .init(
            top: top + inset,
            bottom: bottom + inset
        )
    }
    
    /// Insets `EdgeInsets_TopBottom` by a given top and bottom values.
    public func insetBy(
        top topInset: CGFloat,
        bottom bottomInset: CGFloat
    ) -> EdgeInsets_TopBottom {
        .init(
            top: top + topInset,
            bottom: bottom + topInset
        )
    }
    
    /// Insets `EdgeInsets_TopBottom` by a given top value.
    public func insetBy(
        top topInset: CGFloat
    ) -> EdgeInsets_TopBottom {
        .init(
            top: top + topInset,
            bottom: bottom
        )
    }
    
    /// Insets `EdgeInsets_TopBottom` by a given bottom value.
    public func insetBy(
        bottom bottomInset: CGFloat
    ) -> EdgeInsets_TopBottom {
        .init(
            top: top,
            bottom: bottom + bottomInset
        )
    }
    
    // MARK: Operators
    /// Adds two `EdgeInsets_TopBottom` by adding up individual edge insets.
    public static func + (lhs: Self, rhs: Self) -> Self {
        .init(
            top: lhs.top + rhs.top,
            bottom: lhs.bottom + rhs.bottom
        )
    }
    
    /// Adds right `EdgeInsets_TopBottom` to the left one by adding individual edge insets.
    public static func += (lhs: inout Self, rhs: Self) {
        lhs.top += rhs.top
        lhs.bottom += rhs.bottom
    }
    
    /// Subtracts two `EdgeInsets_TopBottom` by subtracting up individual edge insets.
    public static func - (lhs: Self, rhs: Self) -> Self {
        .init(
            top: lhs.top - rhs.top,
            bottom: lhs.bottom - rhs.bottom
        )
    }
    
    /// Subtracts right `EdgeInsets_TopBottom` to the left one by subtracting individual edge insets.
    public static func -= (lhs: inout Self, rhs: Self) {
        lhs.top -= rhs.top
        lhs.bottom -= rhs.bottom
    }
}

// MARK: - Padding
extension View {
    /// Adds a specific padding amount to each edge of `View` from `EdgeInsets_TopBottom`.
    ///
    ///     let insets: EdgeInsets_TopBottom = .init(
    ///         top: 10,
    ///         bottom: 10
    ///     )
    ///
    ///     var body: some View {
    ///         Text("Lorem Ipsum")
    ///             .padding(insets)
    ///     }
    ///
    public func padding(_ insets: EdgeInsets_TopBottom) -> some View {
        self
            .padding(.top, insets.top)
            .padding(.bottom, insets.bottom)
    }
}
