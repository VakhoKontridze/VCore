//
//  EdgeInsetsAxis.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/1/21.
//

import SwiftUI

// MARK: - Edge Insets (Horizontal, Vertical)
/// Edge insets containing `horizontal` and `vertical` values.
@MemberwiseInitializable(
    comment: "/// Initializes `EdgeInsetsAxis` with values."
)
public struct EdgeInsetsAxis: Equatable, Hashable, Sendable {
    // MARK: Properties
    /// Horizontal value.
    public var horizontal: CGFloat
    
    /// Vertical value.
    public var vertical: CGFloat
    
    // MARK: Initializers
    /// Initializes `EdgeInsetsAxis` with value.
    public init(
        _ value: CGFloat
    ) {
        self.horizontal = value
        self.vertical = value
    }
    
    /// Initializes `EdgeInsetsAxis` with zero values.
    public init() {
        self.horizontal = 0
        self.vertical = 0
    }

    // MARK: Mapping
    /// Converts `EdgeInsetsAxis` to `EdgeInsets`.
    public var toEdgeInsets: EdgeInsets {
        .init(
            top: vertical,
            leading: horizontal,
            bottom: vertical,
            trailing: horizontal
        )
    }

    /// Converts `EdgeInsetsAxis` to `NSDirectionalEdgeInsets`.
    public var toNSDirectionalEdgeInsets: NSDirectionalEdgeInsets {
        .init(
            top: vertical,
            leading: horizontal,
            bottom: vertical,
            trailing: horizontal
        )
    }

#if canImport(UIKit)

    /// Converts `EdgeInsetsAxis` to `UIEdgeInsets`.
    public var toUIEdgeInsets: UIEdgeInsets {
        .init(
            top: vertical,
            left: horizontal,
            bottom: vertical,
            right: horizontal
        )
    }

#elseif canImport(AppKit)

    /// Converts `EdgeInsetsAxis` to `NSEdgeInsets`.
    public var toNSEdgeInsets: NSEdgeInsets {
        .init(
            top: vertical,
            left: horizontal,
            bottom: vertical,
            right: horizontal
        )
    }

#endif

    // MARK: Map
    /// Returns `EdgeInsetsAxis`  containing the results of mapping the given closure over the values.
    public func map(
        _ transform: (CGFloat) throws -> CGFloat
    ) rethrows -> Self {
        .init(
            horizontal: try transform(horizontal),
            vertical: try transform(vertical)
        )
    }

    // MARK: Inset
    /// Insets `EdgeInsetsAxis` by a given value.
    public func insetBy(
        inset: CGFloat
    ) -> EdgeInsetsAxis {
        .init(
            horizontal: horizontal + inset,
            vertical: vertical + inset
        )
    }
    
    /// Insets `EdgeInsetsAxis` by a given horizontal and vertical values.
    public func insetBy(
        horizontal horizontalInset: CGFloat,
        vertical verticalInset: CGFloat
    ) -> EdgeInsetsAxis {
        .init(
            horizontal: horizontal + horizontalInset,
            vertical: vertical + horizontalInset
        )
    }
    
    /// Insets `EdgeInsetsAxis` by a given horizontal value.
    public func insetBy(
        horizontal horizontalInset: CGFloat
    ) -> EdgeInsetsAxis {
        .init(
            horizontal: horizontal + horizontalInset,
            vertical: vertical
        )
    }
    
    /// Insets `EdgeInsetsAxis` by a given vertical value.
    public func insetBy(
        vertical verticalInset: CGFloat
    ) -> EdgeInsetsAxis {
        .init(
            horizontal: horizontal,
            vertical: vertical + verticalInset
        )
    }
    
    // MARK: Operators
    /// Adds two `EdgeInsetsAxis` by adding up individual edge insets.
    public static func + (lhs: Self, rhs: Self) -> Self {
        .init(
            horizontal: lhs.horizontal + rhs.horizontal,
            vertical: lhs.vertical + rhs.vertical
        )
    }
    
    /// Adds right `EdgeInsetsAxis` to the left one by adding individual edge insets.
    public static func += (lhs: inout Self, rhs: Self) {
        lhs.horizontal += rhs.horizontal
        lhs.vertical += rhs.vertical
    }
    
    /// Subtracts two `EdgeInsetsAxis` by subtracting up individual edge insets.
    public static func - (lhs: Self, rhs: Self) -> EdgeInsetsAxis {
        .init(
            horizontal: lhs.horizontal - rhs.horizontal,
            vertical: lhs.vertical - rhs.vertical
        )
    }
    
    /// Subtracts right `EdgeInsetsAxis` to the left one by subtracting individual edge insets.
    public static func -= (lhs: inout Self, rhs: Self) {
        lhs.horizontal -= rhs.horizontal
        lhs.vertical -= rhs.vertical
    }
}

// MARK: - View + Padding
extension View {
    /// Adds a specific padding amount to each edge of `View` from `EdgeInsetsAxis`.
    ///
    ///     let insets: EdgeInsetsAxis = .init(
    ///         horizontal: 10,
    ///         vertical: 10
    ///     )
    ///
    ///     var body: some View {
    ///         Text("Lorem Ipsum")
    ///             .padding(insets)
    ///     }
    ///
    public func padding(_ insets: EdgeInsetsAxis) -> some View {
        self
            .padding(.leading, insets.horizontal)
            .padding(.trailing, insets.horizontal)
            .padding(.top, insets.vertical)
            .padding(.bottom, insets.vertical)
    }
}
