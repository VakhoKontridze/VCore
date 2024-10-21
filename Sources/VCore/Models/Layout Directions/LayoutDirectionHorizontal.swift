//
//  LayoutDirectionHorizontal.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 27.02.23.
//

import SwiftUI

// MARK: - Layout Direction Horizontal
/// Horizontal directional layout in which content can be laid out.
///
/// Unlike `SwiftUI.LayoutDirection`, `LayoutDirectionHorizontal` is exhaustive.
public enum LayoutDirectionHorizontal: Int, Sendable, CaseIterable {
    // MARK: Cases
    /// Left-to-right direction.
    case leftToRight
    
    /// Right-to-left direction.
    case rightToLeft
    
    // MARK: Properties
    /// Indicates if layout direction is reversed.
    public var isReversed: Bool {
        switch self {
        case .leftToRight: false
        case .rightToLeft: true
        }
    }

    // MARK: Reversing
    /// Returns reversed dimension.
    public func reversed() -> Self {
        switch self {
        case .leftToRight: .rightToLeft
        case .rightToLeft: .leftToRight
        }
    }

    // MARK: Mapping
    /// Converts `LayoutDirectionHorizontal` to `Alignment`.
    public var toAlignment: Alignment {
        switch self {
        case .leftToRight: .leading
        case .rightToLeft: .trailing
        }
    }
    
    /// Converts `LayoutDirectionHorizontal` to `Edge`.
    public var toEdge: Edge {
        switch self {
        case .leftToRight: .leading
        case .rightToLeft: .trailing
        }
    }
    
    /// Converts `LayoutDirectionHorizontal` to `Edge.Set`.
    public var toEdgeSet: Edge.Set {
        switch self {
        case .leftToRight: .leading
        case .rightToLeft: .trailing
        }
    }
}
