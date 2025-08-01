//
//  LayoutDirection.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 27.02.23.
//

import SwiftUI

extension LayoutDirection {
    // MARK: Properties
    /// Indicates if layout direction is reversed.
    public var isReversed: Bool {
        switch self {
        case .leftToRight: false
        case .rightToLeft: true
        @unknown default: false
        }
    }

    // MARK: Reversing
    /// Returns reversed dimension.
    public func reversed() -> Self {
        switch self {
        case .leftToRight: .rightToLeft
        case .rightToLeft: .leftToRight
        @unknown default: .rightToLeft
        }
    }

    // MARK: Mapping
    /// Converts `LayoutDirectionHorizontal` to `Alignment`.
    public var toAlignment: Alignment {
        switch self {
        case .leftToRight: .leading
        case .rightToLeft: .trailing
        @unknown default: .leading
        }
    }
    
    /// Converts `LayoutDirectionHorizontal` to `Edge`.
    public var toEdge: Edge {
        switch self {
        case .leftToRight: .leading
        case .rightToLeft: .trailing
        @unknown default: .leading
        }
    }
    
    /// Converts `LayoutDirectionHorizontal` to `Edge.Set`.
    public var toEdgeSet: Edge.Set {
        switch self {
        case .leftToRight: .leading
        case .rightToLeft: .trailing
        @unknown default: .leading
        }
    }
}
