//
//  EdgeInsets_LeadingTrailing.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/1/21.
//

import SwiftUI

// MARK: - Edge Insets (Leading, Trailing)
/// Edge insets containing `leading` and `trailing` values.
@MemberwiseInitializable(
    comment: "/// Initializes `EdgeInsets_LeadingTrailing` with values."
)
public struct EdgeInsets_LeadingTrailing: Equatable, Hashable {
    // MARK: Properties
    /// Leading value.
    public var leading: CGFloat
    
    /// Trailing value.
    public var trailing: CGFloat
    
    /// Sum of `leading` and `trailing` values.
    public var horizontalSum: CGFloat { leading + trailing }
    
    /// Average of `leading` and `trailing` values.
    public var horizontalAverage: CGFloat { (leading + trailing)/2 }
    
    // MARK: Initializers
    /// Initializes `EdgeInsets_LeadingTrailing` with value.
    public init(
        _ value: CGFloat
    ) {
        self.leading = value
        self.trailing = value
    }
    
    /// Initializes `EdgeInsets_LeadingTrailing` with zero values.
    public init() {
        self.leading = 0
        self.trailing = 0
    }
    
    /// Initializes `EdgeInsets_LT` with zero values.
    public static var zero: Self { .init() }

    // MARK: Map
    /// Returns `EdgeInsets_LeadingTrailing`  containing the results of mapping the given closure over the values.
    public func map(
        _ transform: (CGFloat) throws -> CGFloat
    ) rethrows -> Self {
        .init(
            leading: try transform(leading),
            trailing: try transform(trailing)
        )
    }

    // MARK: Inset
    /// Insets `EdgeInsets_LeadingTrailing` by a given value.
    public func insetBy(
        inset: CGFloat
    ) -> EdgeInsets_LeadingTrailing {
        .init(
            leading: leading + inset,
            trailing: trailing + inset
        )
    }
    
    /// Insets `EdgeInsets_LeadingTrailing` by a given leading and trailing values.
    public func insetBy(
        leading leadingInset: CGFloat,
        trailing trailingInset: CGFloat
    ) -> EdgeInsets_LeadingTrailing {
        .init(
            leading: leading + leadingInset,
            trailing: trailing + leadingInset
        )
    }
    
    /// Insets `EdgeInsets_LeadingTrailing` by a given leading value.
    public func insetBy(
        leading leadingInset: CGFloat
    ) -> EdgeInsets_LeadingTrailing {
        .init(
            leading: leading + leadingInset,
            trailing: trailing
        )
    }
    
    /// Insets `EdgeInsets_LeadingTrailing` by a given trailing value.
    public func insetBy(
        trailing trailingInset: CGFloat
    ) -> EdgeInsets_LeadingTrailing {
        .init(
            leading: leading,
            trailing: trailing + trailingInset
        )
    }
    
    // MARK: Operators
    /// Adds two `EdgeInsets_LeadingTrailing` by adding up individual edge insets.
    public static func + (lhs: Self, rhs: Self) -> Self {
        .init(
            leading: lhs.leading + rhs.leading,
            trailing: lhs.trailing + rhs.trailing
        )
    }
    
    /// Adds right `EdgeInsets_LeadingTrailing` to the left one by adding individual edge insets.
    public static func += (lhs: inout Self, rhs: Self) {
        lhs.leading += rhs.leading
        lhs.trailing += rhs.trailing
    }
    
    /// Subtracts two `EdgeInsets_LeadingTrailing` by subtracting up individual edge insets.
    public static func - (lhs: Self, rhs: Self) -> Self {
        .init(
            leading: lhs.leading - rhs.leading,
            trailing: lhs.trailing - rhs.trailing
        )
    }
    
    /// Subtracts right `EdgeInsets_LeadingTrailing` to the left one by subtracting individual edge insets.
    public static func -= (lhs: inout Self, rhs: Self) {
        lhs.leading -= rhs.leading
        lhs.trailing -= rhs.trailing
    }
}

// MARK: - View + Padding
extension View {
    /// Adds a specific padding amount to each edge of `View` from `EdgeInsets_LeadingTrailing`.
    ///
    ///     let insets: EdgeInsets_LeadingTrailing = .init(
    ///         leading: 10,
    ///         trailing: 10
    ///     )
    ///
    ///     var body: some View {
    ///         Text("Lorem Ipsum")
    ///             .padding(insets)
    ///     }
    ///
    public func padding(_ insets: EdgeInsets_LeadingTrailing) -> some View {
        self
            .padding(.leading, insets.leading)
            .padding(.trailing, insets.trailing)
    }
}
