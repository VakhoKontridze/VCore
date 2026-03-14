//
//  EdgeInsetsHorizontal.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/1/21.
//

import SwiftUI

/// Edge insets containing `leading` and `trailing` values.
@MemberwiseInitializable(
    comment: "/// Initializes `EdgeInsetsHorizontal` with values."
)
public nonisolated struct EdgeInsetsHorizontal: Equatable, Hashable, Sendable {
    // MARK: Properties - Base
    /// Leading value.
    public var leading: CGFloat
    
    /// Trailing value.
    public var trailing: CGFloat
    
    // MARK: Properties - Derived
    /// Sum of `leading` and `trailing` values.
    public var horizontalSum: CGFloat { leading + trailing }
    
    /// Average of `leading` and `trailing` values.
    public var horizontalAverage: CGFloat { (leading + trailing)/2 }
    
    // MARK: Initializers
    /// Initializes `EdgeInsetsHorizontal` with value.
    public init(
        _ value: CGFloat
    ) {
        self.leading = value
        self.trailing = value
    }
    
    /// Initializes `EdgeInsetsHorizontal` with zero values.
    public init() {
        self.leading = 0
        self.trailing = 0
    }

    // MARK: Map
    /// Returns `EdgeInsetsHorizontal`  containing the results of mapping the given closure over the values.
    public func map(
        _ transform: (CGFloat) throws -> CGFloat
    ) rethrows -> Self {
        .init(
            leading: try transform(leading),
            trailing: try transform(trailing)
        )
    }

    // MARK: Inset
    /// Insets `EdgeInsetsHorizontal` by a given value.
    public func insetBy(
        inset: CGFloat
    ) -> EdgeInsetsHorizontal {
        .init(
            leading: leading + inset,
            trailing: trailing + inset
        )
    }
    
    /// Insets `EdgeInsetsHorizontal` by a given leading and trailing values.
    public func insetBy(
        leading leadingInset: CGFloat,
        trailing trailingInset: CGFloat
    ) -> EdgeInsetsHorizontal {
        .init(
            leading: leading + leadingInset,
            trailing: trailing + trailingInset
        )
    }
    
    /// Insets `EdgeInsetsHorizontal` by a given leading value.
    public func insetBy(
        leading leadingInset: CGFloat
    ) -> EdgeInsetsHorizontal {
        .init(
            leading: leading + leadingInset,
            trailing: trailing
        )
    }
    
    /// Insets `EdgeInsetsHorizontal` by a given trailing value.
    public func insetBy(
        trailing trailingInset: CGFloat
    ) -> EdgeInsetsHorizontal {
        .init(
            leading: leading,
            trailing: trailing + trailingInset
        )
    }
    
    // MARK: Operators
    /// Adds two `EdgeInsetsHorizontal` by adding up individual edge insets.
    public static func + (lhs: Self, rhs: Self) -> Self {
        .init(
            leading: lhs.leading + rhs.leading,
            trailing: lhs.trailing + rhs.trailing
        )
    }
    
    /// Adds right `EdgeInsetsHorizontal` to the left one by adding individual edge insets.
    public static func += (lhs: inout Self, rhs: Self) {
        lhs.leading += rhs.leading
        lhs.trailing += rhs.trailing
    }
    
    /// Subtracts two `EdgeInsetsHorizontal` by subtracting up individual edge insets.
    public static func - (lhs: Self, rhs: Self) -> Self {
        .init(
            leading: lhs.leading - rhs.leading,
            trailing: lhs.trailing - rhs.trailing
        )
    }
    
    /// Subtracts right `EdgeInsetsHorizontal` to the left one by subtracting individual edge insets.
    public static func -= (lhs: inout Self, rhs: Self) {
        lhs.leading -= rhs.leading
        lhs.trailing -= rhs.trailing
    }
}

nonisolated extension View {
    /// Adds a specific padding amount to each edge of `View` from `EdgeInsetsHorizontal`.
    ///
    ///     let insets: EdgeInsetsHorizontal = .init(
    ///         leading: 10,
    ///         trailing: 10
    ///     )
    ///
    ///     var body: some View {
    ///         Text("Lorem Ipsum")
    ///             .padding(insets)
    ///     }
    ///
    public func padding(_ insets: EdgeInsetsHorizontal) -> some View {
        self
            .padding(.leading, insets.leading)
            .padding(.trailing, insets.trailing)
    }
}
