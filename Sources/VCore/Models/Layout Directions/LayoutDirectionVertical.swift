//
//  LayoutDirectionVertical.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 27.02.23.
//

import SwiftUI

// MARK: - Layout Direction Vertical
/// Vertical directional layout in which content can be laid out.
///
/// Unlike `SwiftUI.LayoutDirection`, `LayoutDirectionVertical` only supports vertical layouts.
public enum LayoutDirectionVertical: CaseIterable {
    // MARK: Cases
    /// Bottom-to-top direction.
    case topToBottom
    
    /// Top-to-bottom direction.
    case bottomToTop
    
    // MARK: Properties
    /// Indicates if layout direction is reversed, such as `bottomToTop`.
    public var isReversed: Bool {
        switch self {
        case .topToBottom: false
        case .bottomToTop: true
        }
    }

    // MARK: Reversing
    /// Returns reversed dimension.
    public func reversed() -> Self {
        switch self {
        case .topToBottom: .bottomToTop
        case .bottomToTop: .topToBottom
        }
    }

    // MARK: Mapping
    /// Converts `LayoutDirectionVertical` to `Alignment`.
    public var toAlignment: Alignment {
        switch self {
        case .topToBottom: .top
        case .bottomToTop: .bottom
        }
    }
    
    /// Converts `LayoutDirectionVertical` to `Edge`.
    public var toEdge: Edge {
        switch self {
        case .topToBottom: .top
        case .bottomToTop: .bottom
        }
    }
    
    /// Converts `LayoutDirectionVertical` to `Edge.Set`.
    public var toEdgeSet: Edge {
        switch self {
        case .topToBottom: .top
        case .bottomToTop: .bottom
        }
    }
}
