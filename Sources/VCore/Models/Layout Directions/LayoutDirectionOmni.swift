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
@CaseDetection
public enum LayoutDirectionOmni: Int, CaseIterable {
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
    
    /// Indicates if layout direction is reversed.
    public var isReversed: Bool {
        switch self {
        case .leftToRight: false
        case .rightToLeft: true
        case .topToBottom: false
        case .bottomToTop: true
        }
    }

    // MARK: Reversing
    /// Returns reversed dimension.
    public func reversed() -> Self {
        switch self {
        case .leftToRight: .rightToLeft
        case .rightToLeft: .leftToRight
        case .topToBottom: .bottomToTop
        case .bottomToTop: .topToBottom
        }
    }

    // MARK: Mapping
    /// Converts `LayoutDirectionOmni` to `Axis`.
    public var toAxis: Axis {
        switch self {
        case .leftToRight: .horizontal
        case .rightToLeft: .horizontal
        case .topToBottom: .vertical
        case .bottomToTop: .vertical
        }
    }
    
    /// Converts `LayoutDirectionOmni` to `Alignment`.
    public var toAlignment: Alignment {
        switch self {
        case .leftToRight: .leading
        case .rightToLeft: .trailing
        case .topToBottom: .top
        case .bottomToTop: .bottom
        }
    }
    
    /// Converts `LayoutDirectionOmni` to `Edge`.
    public var toEdge: Edge {
        switch self {
        case .leftToRight: .leading
        case .rightToLeft: .trailing
        case .topToBottom: .top
        case .bottomToTop: .bottom
        }
    }
    
    /// Converts `LayoutDirectionOmni` to `Edge.Set`.
    public var toEdgeSet: Edge.Set {
        switch self {
        case .leftToRight: .leading
        case .rightToLeft: .trailing
        case .topToBottom: .top
        case .bottomToTop: .bottom
        }
    }
    
    // MARK: Stack Layout
    /// Creates stack `Layout` based on axis of direction.
    ///
    /// For `leftToRight` or `rightToLeft`, `HStackLayout` will be used.
    /// For `topToBottom` or `bottomToTop`, `VStackLayout` will be used.
    public func stackLayout(
        alignmentHorizontal: HorizontalAlignment = .center,
        alignmentVertical: VerticalAlignment = .center,
        spacing: CGFloat? = nil
    ) -> AnyLayout {
        if isHorizontal {
            AnyLayout(
                HStackLayout(
                    alignment: alignmentVertical,
                    spacing: spacing
                )
            )

        } else {
            AnyLayout(
                VStackLayout(
                    alignment: alignmentHorizontal,
                    spacing: spacing
                )
            )
        }
    }
}
