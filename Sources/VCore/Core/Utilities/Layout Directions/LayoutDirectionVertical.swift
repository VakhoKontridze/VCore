//
//  LayoutDirectionVertical.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 27.02.23.
//

import SwiftUI

/// Vertical directional layout in which content can be laid out.
///
/// Unlike `SwiftUI.LayoutDirection`, `LayoutDirectionVertical` only supports vertical layouts.
nonisolated public enum LayoutDirectionVertical: Int, Sendable, CaseIterable {
    // MARK: Cases
    /// Top-to-bottom direction.
    case topToBottom
    
    /// Bottom-to-top direction.
    case bottomToTop
    
    // MARK: Properties
    /// Indicates if layout direction is reversed.
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
    
    /// Converts `LayoutDirectionVertical` to `Edge`.
    public var toEdgeSet: Edge {
        switch self {
        case .topToBottom: .top
        case .bottomToTop: .bottom
        }
    }
}
