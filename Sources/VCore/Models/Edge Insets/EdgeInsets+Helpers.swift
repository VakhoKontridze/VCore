//
//  EdgeInsets.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/1/21.
//

import SwiftUI

// MARK: - Edge Insets
extension EdgeInsets {
    // MARK: Properties - Derived
    /// Sum of `leading` and `trailing` values.
    public var horizontalSum: CGFloat { leading + trailing }
    
    /// Average of `leading` and `trailing` values.
    public var horizontalAverage: CGFloat { (leading + trailing)/2 }
    
    /// Sum of `top` and `bottom` values.
    public var verticalSum: CGFloat { top + bottom }
    
    /// Average of `top` and `bottom` values.
    public var verticalAverage: CGFloat { (top + bottom)/2 }
    
    // MARK: Initializers
    /// Initializes `EdgeInsets` with values.
    public init( // Duplicate `init` that orders properties by horizontal first, vertical second
        leading: CGFloat,
        trailing: CGFloat,
        top: CGFloat,
        bottom: CGFloat
    ) {
        self.init(
            top: top,
            leading: leading,
            bottom: bottom,
            trailing: trailing
        )
    }
    
    /// Initializes `EdgeInsets` with horizontal and vertical values.
    public init(
        horizontal: CGFloat,
        vertical: CGFloat
    ) {
        self.init(
            leading: horizontal,
            trailing: horizontal,
            top: vertical,
            bottom: vertical
        )
    }
    
    /// Initializes `EdgeInsets` with value.
    public init(
        _ value: CGFloat
    ) {
        self.init(
            leading: value,
            trailing: value,
            top: value,
            bottom: value
        )
    }

    /// Initializes `EdgeInsets` with `NSDirectionalEdgeInsets`.
    public init(_ nsEdgeInsets: NSDirectionalEdgeInsets) {
        self.init(
            leading: nsEdgeInsets.leading,
            trailing: nsEdgeInsets.trailing,
            top: nsEdgeInsets.top,
            bottom: nsEdgeInsets.bottom
        )
    }

#if canImport(UIKit)

    /// Initializes `EdgeInsets` with `UIEdgeInsets`.
    public init(_ uiEdgeInsets: UIEdgeInsets) {
        self.init(
            leading: uiEdgeInsets.left,
            trailing: uiEdgeInsets.right,
            top: uiEdgeInsets.top,
            bottom: uiEdgeInsets.bottom
        )
    }

#elseif canImport(AppKit)

    /// Initializes `EdgeInsets` with `NSEdgeInsets`.
    public init(_ nsEdgeInsets: NSEdgeInsets) {
        self.init(
            leading: nsEdgeInsets.leading,
            trailing: nsEdgeInsets.trailing,
            top: nsEdgeInsets.top,
            bottom: nsEdgeInsets.bottom
        )
    }

#endif

    // MARK: Mapping
    /// Converts `EdgeInsets` to `NSDirectionalEdgeInsets`.
    public var toNSDirectionalEdgeInsets: NSDirectionalEdgeInsets {
        .init(
            top: top,
            leading: leading,
            bottom: bottom,
            trailing: trailing
        )
    }

#if canImport(UIKit)

    /// Converts `EdgeInsets` to `UIEdgeInsets`.
    public var toUIEdgeInsets: UIEdgeInsets {
        .init(
            top: top,
            left: leading,
            bottom: bottom,
            right: trailing
        )
    }

#elseif canImport(AppKit)

    /// Converts `EdgeInsets` to `NSEdgeInsets`.
    public var toNSEdgeInsets: NSEdgeInsets {
        .init(
            top: top,
            left: leading,
            bottom: bottom,
            right: trailing
        )
    }

#endif

    // MARK: Map
    /// Returns `EdgeInsets`  containing the results of mapping the given closure over the values.
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
    /// Insets `EdgeInsets` by a given value.
    public func insetBy(
        inset: CGFloat
    ) -> EdgeInsets {
        .init(
            leading: leading + inset,
            trailing: trailing + inset,
            top: top + inset,
            bottom: bottom + inset
        )
    }
    
    /// Insets `EdgeInsets` by a given horizontal and vertical values.
    public func insetBy(
        horizontal horizontalInset: CGFloat,
        vertical verticalInset: CGFloat
    ) -> EdgeInsets {
        .init(
            leading: leading + horizontalInset,
            trailing: trailing + horizontalInset,
            top: top + verticalInset,
            bottom: bottom + verticalInset
        )
    }
    
    /// Insets `EdgeInsets` by a given leading value.
    public func insetBy(
        leading leadingInset: CGFloat
    ) -> EdgeInsets {
        .init(
            leading: leading + leadingInset,
            trailing: trailing,
            top: top,
            bottom: bottom
        )
    }
    
    /// Insets `EdgeInsets` by a given trailing value.
    public func insetBy(
        trailing trailingInset: CGFloat
    ) -> EdgeInsets {
        .init(
            leading: leading,
            trailing: trailing + trailingInset,
            top: top,
            bottom: bottom
        )
    }
    
    /// Insets `EdgeInsets` by a given top value.
    public func insetBy(
        top topInset: CGFloat
    ) -> EdgeInsets {
        .init(
            leading: leading,
            trailing: trailing,
            top: top + topInset,
            bottom: bottom
        )
    }
    
    /// Insets `EdgeInsets` by a given bottom value.
    public func insetBy(
        bottom bottomInset: CGFloat
    ) -> EdgeInsets {
        .init(
            leading: leading,
            trailing: trailing,
            top: top,
            bottom: bottom + bottomInset
        )
    }
    
    // MARK: Operators
    /// Adds two `EdgeInsets` by adding up individual edge insets.
    public static func + (lhs: Self, rhs: Self) -> Self {
        .init(
            leading: lhs.leading + rhs.leading,
            trailing: lhs.trailing + rhs.trailing,
            top: lhs.top + rhs.top,
            bottom: lhs.bottom + rhs.bottom
        )
    }
    
    /// Adds right `EdgeInsets` to the left one by adding individual edge insets.
    public static func += (lhs: inout Self, rhs: Self) {
        lhs.leading += rhs.leading
        lhs.trailing += rhs.trailing
        lhs.top += rhs.top
        lhs.bottom += rhs.bottom
    }
    
    /// Subtracts two `EdgeInsets` by subtracting up individual edge insets.
    public static func - (lhs: Self, rhs: Self) -> Self {
        .init(
            leading: lhs.leading - rhs.leading,
            trailing: lhs.trailing - rhs.trailing,
            top: lhs.top - rhs.top,
            bottom: lhs.bottom - rhs.bottom
        )
    }
    
    /// Subtracts right `EdgeInsets` to the left one by subtracting individual edge insets.
    public static func -= (lhs: inout Self, rhs: Self) {
        lhs.leading -= rhs.leading
        lhs.trailing -= rhs.trailing
        lhs.top -= rhs.top
        lhs.bottom -= rhs.bottom
    }
}
