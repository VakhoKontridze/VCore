//
//  EdgeInsets_LeadingTrailingTopBottom.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/1/21.
//

import SwiftUI

// MARK: - Edge Insets (Leading, Trailing, Top, Bottom)
/// Edge insets containing `leading`, `trailing`, `top` and `bottom` values.
public struct EdgeInsets_LeadingTrailingTopBottom: Equatable, Hashable {
    // MARK: Properties
    /// Leading inset value.
    public var leading: CGFloat
    
    /// Trailing inset value.
    public var trailing: CGFloat
    
    /// Top inset value.
    public var top: CGFloat
    
    /// Bottom inset value.
    public var bottom: CGFloat
    
    /// Sum of `leading` and `trailing` values.
    public var horizontalSum: CGFloat { leading + trailing }
    
    /// Average of `leading` and `trailing` values.
    public var horizontalAverage: CGFloat { (leading + trailing)/2 }
    
    /// Sum of `top` and `bottom` values.
    public var verticalSum: CGFloat { top + bottom }
    
    /// Average of `top` and `bottom` values.
    public var verticalAverage: CGFloat { (top + bottom)/2 }
    
    // MARK: Initializers
    /// Initializes `EdgeInsets_LeadingTrailingTopBottom` with values.
    public init(
        leading: CGFloat,
        trailing: CGFloat,
        top: CGFloat,
        bottom: CGFloat
    ) {
        self.leading = leading
        self.trailing = trailing
        self.top = top
        self.bottom = bottom
    }
    
    /// Initializes `EdgeInsets_LeadingTrailingTopBottom` with horizontal and vertical values.
    public init(
        horizontal: CGFloat,
        vertical: CGFloat
    ) {
        self.leading = horizontal
        self.trailing = horizontal
        self.top = vertical
        self.bottom = vertical
    }
    
    /// Initializes `EdgeInsets_LeadingTrailingTopBottom` with value.
    public init(
        _ value: CGFloat
    ) {
        self.leading = value
        self.trailing = value
        self.top = value
        self.bottom = value
    }
    
    /// Initializes `EdgeInsets_LeadingTrailingTopBottom` with zero values.
    public init() {
        self.leading = 0
        self.trailing = 0
        self.top = 0
        self.bottom = 0
    }
    
    /// Initializes `EdgeInsets_LeadingTrailingTopBottom` with `EdgeInsets`.
    public init(_ edgeInsets: EdgeInsets) {
        self.leading = edgeInsets.leading
        self.trailing = edgeInsets.trailing
        self.top = edgeInsets.top
        self.bottom = edgeInsets.bottom
    }

    /// Initializes `EdgeInsets_LeadingTrailingTopBottom` with `NSDirectionalEdgeInsets`.
    public init(_ nsEdgeInsets: NSDirectionalEdgeInsets) {
        self.leading = nsEdgeInsets.leading
        self.trailing = nsEdgeInsets.trailing
        self.top = nsEdgeInsets.top
        self.bottom = nsEdgeInsets.bottom
    }

#if canImport(UIKit)

    /// Initializes `EdgeInsets_LeadingTrailingTopBottom` with `UIEdgeInsets`.
    public init(_ uiEdgeInsets: UIEdgeInsets) {
        self.leading = uiEdgeInsets.left
        self.trailing = uiEdgeInsets.right
        self.top = uiEdgeInsets.top
        self.bottom = uiEdgeInsets.bottom
    }

#elseif canImport(AppKit)

    /// Initializes `EdgeInsets_LeadingTrailingTopBottom` with `NSEdgeInsets`.
    public init(_ nsEdgeInsets: NSEdgeInsets) {
        self.leading = nsEdgeInsets.left
        self.trailing = nsEdgeInsets.right
        self.top = nsEdgeInsets.top
        self.bottom = nsEdgeInsets.bottom
    }

#endif
    
    /// Initializes `EdgeInsets_LeadingTrailingTopBottom` with zero values.
    public static var zero: Self { .init() }

    // MARK: Mapping
    /// Converts `EdgeInsets_TopBottom` to `EdgeInsets`.
    var toEdgeInsets: EdgeInsets {
        .init(
            top: top,
            leading: leading,
            bottom: bottom,
            trailing: trailing
        )
    }

    /// Converts `EdgeInsets_TopBottom` to `NSDirectionalEdgeInsets`.
    var toNSDirectionalEdgeInsets: NSDirectionalEdgeInsets {
        .init(
            top: top,
            leading: leading,
            bottom: bottom,
            trailing: trailing
        )
    }

#if canImport(UIKit)

    /// Converts `EdgeInsets_TopBottom` to `UIEdgeInsets`.
    var toUIEdgeInsets: UIEdgeInsets {
        .init(
            top: top,
            left: leading,
            bottom: bottom,
            right: trailing
        )
    }

#elseif canImport(AppKit)

    /// Converts `EdgeInsets_TopBottom` to `NSEdgeInsets`.
    var toNSEdgeInsets: NSEdgeInsets {
        .init(
            top: top,
            left: leading,
            bottom: bottom,
            right: trailing
        )
    }

#endif

    // MARK: Map
    /// Returns `EdgeInsets_LeadingTrailingTopBottom`  containing the results of mapping the given closure over the values.
    public func map(
        _ transform: (CGFloat) throws -> CGFloat
    ) rethrows -> Self {
        .init(
            leading: try transform(leading),
            trailing: try transform(trailing),
            top: try transform(top),
            bottom: try transform(bottom)
        )
    }

    // MARK: Inset
    /// Insets `EdgeInsets_LeadingTrailingTopBottom` by a given value.
    public func insetBy(
        inset: CGFloat
    ) -> EdgeInsets_LeadingTrailingTopBottom {
        .init(
            leading: leading + inset,
            trailing: trailing + inset,
            top: top + inset,
            bottom: bottom + inset
        )
    }
    
    /// Insets `EdgeInsets_LeadingTrailingTopBottom` by a given horizontal and vertical values.
    public func insetBy(
        horizontal horizontalInset: CGFloat,
        vertical verticalInset: CGFloat
    ) -> EdgeInsets_LeadingTrailingTopBottom {
        .init(
            leading: leading + horizontalInset,
            trailing: trailing + horizontalInset,
            top: top + verticalInset,
            bottom: bottom + verticalInset
        )
    }
    
    /// Insets `EdgeInsets_LeadingTrailingTopBottom` by a given leading value.
    public func insetBy(
        leading leadingInset: CGFloat
    ) -> EdgeInsets_LeadingTrailingTopBottom {
        .init(
            leading: leading + leadingInset,
            trailing: trailing,
            top: top,
            bottom: bottom
        )
    }
    
    /// Insets `EdgeInsets_LeadingTrailingTopBottom` by a given trailing value.
    public func insetBy(
        trailing trailingInset: CGFloat
    ) -> EdgeInsets_LeadingTrailingTopBottom {
        .init(
            leading: leading,
            trailing: trailing + trailingInset,
            top: top,
            bottom: bottom
        )
    }
    
    /// Insets `EdgeInsets_LeadingTrailingTopBottom` by a given top value.
    public func insetBy(
        top topInset: CGFloat
    ) -> EdgeInsets_LeadingTrailingTopBottom {
        .init(
            leading: leading,
            trailing: trailing,
            top: top + topInset,
            bottom: bottom
        )
    }
    
    /// Insets `EdgeInsets_LeadingTrailingTopBottom` by a given bottom value.
    public func insetBy(
        bottom bottomInset: CGFloat
    ) -> EdgeInsets_LeadingTrailingTopBottom {
        .init(
            leading: leading,
            trailing: trailing,
            top: top,
            bottom: bottom + bottomInset
        )
    }
    
    // MARK: Operators
    /// Adds two `EdgeInsets_LeadingTrailingTopBottom` by adding up individual edge insets.
    public static func + (lhs: Self, rhs: Self) -> Self {
        .init(
            leading: lhs.leading + rhs.leading,
            trailing: lhs.trailing + rhs.trailing,
            top: lhs.top + rhs.top,
            bottom: lhs.bottom + rhs.bottom
        )
    }
    
    /// Adds right `EdgeInsets_LeadingTrailingTopBottom` to the left one by adding individual edge insets.
    public static func += (lhs: inout Self, rhs: Self) {
        lhs.leading += rhs.leading
        lhs.trailing += rhs.trailing
        lhs.top += rhs.top
        lhs.bottom += rhs.bottom
    }
    
    /// Subtracts two `EdgeInsets_LeadingTrailingTopBottom` by subtracting up individual edge insets.
    public static func - (lhs: Self, rhs: Self) -> Self {
        .init(
            leading: lhs.leading - rhs.leading,
            trailing: lhs.trailing - rhs.trailing,
            top: lhs.top - rhs.top,
            bottom: lhs.bottom - rhs.bottom
        )
    }
    
    /// Subtracts right `EdgeInsets_LeadingTrailingTopBottom` to the left one by subtracting individual edge insets.
    public static func -= (lhs: inout Self, rhs: Self) {
        lhs.leading -= rhs.leading
        lhs.trailing -= rhs.trailing
        lhs.top -= rhs.top
        lhs.bottom -= rhs.bottom
    }
}

// MARK: - Padding
extension View {
    /// Adds a specific padding amount to each edge of this `View` from `EdgeInsets_LeadingTrailingTopBottom`.
    ///
    ///     let insets: EdgeInsets_LeadingTrailingTopBottom = .init(
    ///         leading: 10,
    ///         trailing: 10,
    ///         top: 10,
    ///         bottom: 10
    ///     )
    ///
    ///     var body: some View {
    ///         Text("Lorem Ipsum")
    ///             .padding(insets)
    ///     }
    ///
    public func padding(_ insets: EdgeInsets_LeadingTrailingTopBottom) -> some View {
        self
            .padding(.leading, insets.leading)
            .padding(.trailing, insets.trailing)
            .padding(.top, insets.top)
            .padding(.bottom, insets.bottom)
    }
}
