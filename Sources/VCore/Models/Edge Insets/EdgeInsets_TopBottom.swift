//
//  EdgeInsets_TopBottom.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/1/21.
//

import SwiftUI

// MARK: - Edge Insets (Top, Bottom)
/// Edge insets containing `top` and `bottom` values.
public struct EdgeInsets_TopBottom: Hashable, Equatable {
    // MARK: Properties
    /// Top inset value.
    public var top: CGFloat
    
    /// Bottom inset  value.
    public var bottom: CGFloat
    
    /// Sum of `top` and `bottom` values.
    public var verticalSum: CGFloat { top + bottom }
    
    /// Average of `top` and `bottom` values.
    public var verticalAverage: CGFloat { (top + bottom)/2 }
    
    // MARK: Initializers
    /// Initializes `EdgeInsets_TopBottom` with values.
    public init(
        top: CGFloat,
        bottom: CGFloat
    ) {
        self.top = top
        self.bottom = bottom
    }
    
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
    
    // MARK: Insetting
    /// Insets `EdgeInsets` by a given value.
    public func insetBy(inset: CGFloat) -> EdgeInsets_TopBottom {
        .init(
            top: top + inset,
            bottom: bottom + inset
        )
    }
    
    /// Insets `EdgeInsets` by a given top and bottom values.
    public func insetBy(top topInset: CGFloat, bottom bottomInset: CGFloat) -> EdgeInsets_TopBottom {
        .init(
            top: top + topInset,
            bottom: bottom + topInset
        )
    }
    
    /// Insets `EdgeInsets` by a given top value.
    public func insetBy(top topInset: CGFloat) -> EdgeInsets_TopBottom {
        .init(
            top: top + topInset,
            bottom: bottom
        )
    }
    
    /// Insets `EdgeInsets` by a given bottom value.
    public func insetBy(bottom bottomInset: CGFloat) -> EdgeInsets_TopBottom {
        .init(
            top: top,
            bottom: bottom + bottomInset
        )
    }
    
    // MARK: Operators
    /// Adds two `EdgeInsets` by adding up individual edge insets.
    public static func + (lhs: Self, rhs: Self) -> Self {
        .init(
            top: lhs.top + rhs.top,
            bottom: lhs.bottom + rhs.bottom
        )
    }
    
    /// Adds right `EdgeInsets` to the left one by adding individual edge insets.
    public static func += (lhs: inout Self, rhs: Self) {
        lhs.top += rhs.top
        lhs.bottom += rhs.bottom
    }
    
    /// Subtracts two `EdgeInsets` by subtracting up individual edge insets.
    public static func - (lhs: Self, rhs: Self) -> Self {
        .init(
            top: lhs.top - rhs.top,
            bottom: lhs.bottom - rhs.bottom
        )
    }
    
    /// Subtracts right `EdgeInsets` to the left one by subtracting individual edge insets.
    public static func -= (lhs: inout Self, rhs: Self) {
        lhs.top -= rhs.top
        lhs.bottom -= rhs.bottom
    }
}

// MARK: - Extension
extension View {
    /// Adds a specific padding amount to each edge of this `View` from `EdgeInsets_TopBottom`.
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
