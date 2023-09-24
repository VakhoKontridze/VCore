//
//  LayoutDirectionOmni.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 26.02.23.
//

import SwiftUI

// MARK: - Layout Direction Omni
/// Omni directional layout in which content can be laid out.
///
/// Unlike `SwiftUI.LayoutDirection`, `LayoutDirectionOmni` also supports vertical layouts.
public enum LayoutDirectionOmni: CaseIterable {
    // MARK: Cases
    /// Left-to-right direction.
    case leftToRight
    
    /// Right-to-left direction.
    case rightToLeft
    
    /// Bottom-to-top direction.
    case topToBottom
    
    /// Top-to-bottom direction.
    case bottomToTop
    
    // MARK: Properties
    /// Returns reversed dimension.
    public func reversed() -> Self {
        switch self {
        case .leftToRight: .rightToLeft
        case .rightToLeft: .leftToRight
        case .topToBottom: .bottomToTop
        case .bottomToTop: .topToBottom
        }
    }
    
    /// Indicates if layout direction is horizontal.
    public var isHorizontal: Bool {
        switch self {
        case .leftToRight: true
        case .rightToLeft: true
        case .topToBottom: false
        case .bottomToTop: false
        }
    }
    
    /// Indicates if layout direction is vertical.
    public var isVertical: Bool {
        !isHorizontal
    }
    
    /// Indicates if layout direction is reversed, such as `rightToLeft` or `bottomToTop`.
    public var isReversed: Bool {
        switch self {
        case .leftToRight: false
        case .rightToLeft: true
        case .topToBottom: false
        case .bottomToTop: true
        }
    }
    
    // MARK: SwiftUI
    /// Axis.
    public var axis: Axis {
        switch self {
        case .leftToRight: .horizontal
        case .rightToLeft: .horizontal
        case .topToBottom: .vertical
        case .bottomToTop: .vertical
        }
    }
    
    /// Alignment.
    public var alignment: Alignment {
        switch self {
        case .leftToRight: .leading
        case .rightToLeft: .trailing
        case .topToBottom: .top
        case .bottomToTop: .bottom
        }
    }
    
    /// Edge.
    public var edge: Edge {
        switch self {
        case .leftToRight: .leading
        case .rightToLeft: .trailing
        case .topToBottom: .top
        case .bottomToTop: .bottom
        }
    }
    
    /// Edge.Set.
    public var edgeSet: Edge.Set {
        switch self {
        case .leftToRight: .leading
        case .rightToLeft: .trailing
        case .topToBottom: .top
        case .bottomToTop: .bottom
        }
    }
    
    /// Creates `View` with `HStack` or `VStack`.
    ///
    /// For `leftToRight` or `rightToLeft`, `HStack` will be used.
    /// For `topToBottom` or `bottomToTop`, `VStack` will be used.
    public func stackView<Content>(
        alignmentHor: HorizontalAlignment = .center,
        alignmentVer: VerticalAlignment = .center,
        spacing: CGFloat? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View
        where Content: View
    {
        HVStack(
            alignmentHor: alignmentHor,
            alignmentVer: alignmentVer,
            spacing: spacing,
            isHorizontal: isHorizontal,
            content: content
        )
    }
    
    /// Creates stack `Layout` based on axis of direction.
    ///
    /// For `leftToRight` or `rightToLeft`, `HStackLayout` will be used.
    /// For `topToBottom` or `bottomToTop`, `VStackLayout` will be used.
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    public func stackLayout(
        alignmentHor: HorizontalAlignment = .center,
        alignmentVer: VerticalAlignment = .center,
        spacing: CGFloat? = nil
    ) -> AnyLayout {
        if isHorizontal {
            AnyLayout(HStackLayout(
                alignment: alignmentVer,
                spacing: spacing
            ))
            
        } else {
            AnyLayout(VStackLayout(
                alignment: alignmentHor,
                spacing: spacing
            ))
        }
    }
}
