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
public enum LayoutDirectionHorizontal: CaseIterable {
    // MARK: Cases
    /// Left-to-right direction.
    case leftToRight
    
    /// Right-to-left direction.
    case rightToLeft
    
    // MARK: Properties
    /// Returns reversed dimension.
    public func reversed() -> Self {
        switch self {
        case .leftToRight: return .rightToLeft
        case .rightToLeft: return .leftToRight
        }
    }
    
    /// Indicates if layout direction is reversed, such as `rightToLeft`.
    public var isReversed: Bool {
        switch self {
        case .leftToRight: return false
        case .rightToLeft: return true
        }
    }
    
    // MARK: SwiftUI
    /// Alignment.
    public var alignment: Alignment {
        switch self {
        case .leftToRight: return .leading
        case .rightToLeft: return .trailing
        }
    }
    
    /// Edge.
    public var edge: Edge {
        switch self {
        case .leftToRight: return .leading
        case .rightToLeft: return .trailing
        }
    }
    
    /// Edge.Set.
    public var edgeSet: Edge.Set {
        switch self {
        case .leftToRight: return .leading
        case .rightToLeft: return .trailing
        }
    }
}
