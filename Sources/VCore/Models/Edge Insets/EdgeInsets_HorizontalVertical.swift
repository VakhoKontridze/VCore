//
//  EdgeInsets_HorizontalVertical.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/1/21.
//

import SwiftUI

// MARK: - Edge Insets (Horizontal, Vertical)
/// Edge insets containing `horizontal` and `vertical` values.
public struct EdgeInsets_HorizontalVertical: Equatable, Hashable {
    // MARK: Properties
    /// Horizontal inset value.
    public var horizontal: CGFloat
    
    /// Vertical inset  value.
    public var vertical: CGFloat
    
    /// Leading inset value.
    public var leading: CGFloat { horizontal }
    
    /// Trailing inset value.
    public var trailing: CGFloat { horizontal }
    
    /// Top inset value.
    public var top: CGFloat { vertical }
    
    /// Bottom inset value.
    public var bottom: CGFloat { vertical }
    
    // MARK: Initializers
    /// Initializes `EdgeInsets_HorizontalVertical` with values.
    public init(
        horizontal: CGFloat,
        vertical: CGFloat
    ) {
        self.horizontal = horizontal
        self.vertical = vertical
    }
    
    /// Initializes `EdgeInsets_HorizontalVertical` with value.
    public init(
        _ value: CGFloat
    ) {
        self.horizontal = value
        self.vertical = value
    }
    
    /// Initializes `EdgeInsets_HorizontalVertical` with zero values.
    public init() {
        self.horizontal = 0
        self.vertical = 0
    }
    
    /// Initializes `EdgeInsets_HV` with zero values.
    public static var zero: Self { .init() }
    
    // MARK: Insetting
    /// Insets `EdgeInsets` by a given value.
    public func insetBy(inset: CGFloat) -> EdgeInsets_HorizontalVertical {
        .init(
            horizontal: horizontal + inset,
            vertical: vertical + inset
        )
    }
    
    /// Insets `EdgeInsets` by a given horizontal and vertical values.
    public func insetBy(horizontal horizontalInset: CGFloat, vertical verticalInset: CGFloat) -> EdgeInsets_HorizontalVertical {
        .init(
            horizontal: horizontal + horizontalInset,
            vertical: vertical + horizontalInset
        )
    }
    
    /// Insets `EdgeInsets` by a given horizontal value.
    public func insetBy(horizontal horizontalInset: CGFloat) -> EdgeInsets_HorizontalVertical {
        .init(
            horizontal: horizontal + horizontalInset,
            vertical: vertical
        )
    }
    
    /// Insets `EdgeInsets` by a given vertical value.
    public func insetBy(vertical verticalInset: CGFloat) -> EdgeInsets_HorizontalVertical {
        .init(
            horizontal: horizontal,
            vertical: vertical + verticalInset
        )
    }
    
    // MARK: Operators
    /// Adds two `EdgeInsets` by adding up individual edge insets.
    public static func + (lhs: Self, rhs: Self) -> Self {
        .init(
            horizontal: lhs.horizontal + rhs.horizontal,
            vertical: lhs.vertical + rhs.vertical
        )
    }
    
    /// Adds right `EdgeInsets` to the left one by adding individual edge insets.
    public static func += (lhs: inout Self, rhs: Self) {
        lhs.horizontal += rhs.horizontal
        lhs.vertical += rhs.vertical
    }
    
    /// Subtracts two `EdgeInsets` by subtracting up individual edge insets.
    public static func - (lhs: Self, rhs: Self) -> EdgeInsets_HorizontalVertical {
        .init(
            horizontal: lhs.horizontal - rhs.horizontal,
            vertical: lhs.vertical - rhs.vertical
        )
    }
    
    /// Subtracts right `EdgeInsets` to the left one by subtracting individual edge insets.
    public static func -= (lhs: inout Self, rhs: Self) {
        lhs.horizontal -= rhs.horizontal
        lhs.vertical -= rhs.vertical
    }
}

// MARK: - Padding
extension View {
    /// Adds a specific padding amount to each edge of this `View` from `EdgeInsets_HorizontalVertical`.
    ///
    ///     let insets: EdgeInsets_HorizontalVertical = .init(
    ///         horizontal: 10,
    ///         vertical: 10
    ///     )
    ///
    ///     var body: some View {
    ///         Text("Lorem Ipsum")
    ///             .padding(insets)
    ///     }
    ///
    public func padding(_ insets: EdgeInsets_HorizontalVertical) -> some View {
        self
            .padding(.leading, insets.horizontal)
            .padding(.trailing, insets.horizontal)
            .padding(.top, insets.vertical)
            .padding(.bottom, insets.vertical)
    }
}
