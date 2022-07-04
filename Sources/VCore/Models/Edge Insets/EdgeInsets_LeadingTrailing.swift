//
//  EdgeInsets_LeadingTrailing.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/1/21.
//

import SwiftUI

// MARK: - Edge Insets (Leading, Trailing)
/// Edge insets containing `leading` and `trailing` values.
public struct EdgeInsets_LeadingTrailing: Hashable, Equatable {
    // MARK: Properties
    /// Leading inset value.
    public var leading: CGFloat
    
    /// Trailing inset value.
    public var trailing: CGFloat
    
    // MARK: Initializers
    /// Initializes `EdgeInsets_LeadingTrailing` with values.
    public init(
        leading: CGFloat,
        trailing: CGFloat
    ) {
        self.leading = leading
        self.trailing = trailing
    }
    
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
    
    // MARK: Insetting
    /// Insets `EdgeInsets` by a given value.
    public func insetBy(inset: CGFloat) -> EdgeInsets_LeadingTrailing {
        .init(
            leading: leading + inset,
            trailing: trailing + inset
        )
    }
    
    /// Insets `EdgeInsets` by a given leading and trailing values.
    public func insetBy(leading leadingInset: CGFloat, trailing trailingInset: CGFloat) -> EdgeInsets_LeadingTrailing {
        .init(
            leading: leading + leadingInset,
            trailing: trailing + leadingInset
        )
    }
    
    /// Insets `EdgeInsets` by a given leading value.
    public func insetBy(leading leadingInset: CGFloat) -> EdgeInsets_LeadingTrailing {
        .init(
            leading: leading + leadingInset,
            trailing: trailing
        )
    }
    
    /// Insets `EdgeInsets` by a given trailing value.
    public func insetBy(trailing trailingInset: CGFloat) -> EdgeInsets_LeadingTrailing {
        .init(
            leading: leading,
            trailing: trailing + trailingInset
        )
    }
    
    // MARK: Operators
    /// Adds two `EdgeInsets` by adding up individual edge insets.
    public static func + (lhs: Self, rhs: Self) -> Self {
        .init(
            leading: lhs.leading + rhs.leading,
            trailing: lhs.trailing + rhs.trailing
        )
    }
    
    /// Adds right `EdgeInsets` to the left one by adding individual edge insets.
    public static func += (lhs: inout Self, rhs: Self) {
        lhs.leading += rhs.leading
        lhs.trailing += rhs.trailing
    }
    
    /// Subtracts two `EdgeInsets` by subtracting up individual edge insets.
    public static func - (lhs: Self, rhs: Self) -> Self {
        .init(
            leading: lhs.leading - rhs.leading,
            trailing: lhs.trailing - rhs.trailing
        )
    }
    
    /// Subtracts right `EdgeInsets` to the left one by subtracting individual edge insets.
    public static func -= (lhs: inout Self, rhs: Self) {
        lhs.leading -= rhs.leading
        lhs.trailing -= rhs.trailing
    }
}

// MARK: - Extension
extension View {
    /// Adds a specific padding amount to each edge of this `View` from `EdgeInsets_LeadingTrailing`.
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
