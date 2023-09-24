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
    /// Returns reversed dimension.
    public func reversed() -> Self {
        switch self {
        case .topToBottom: .bottomToTop
        case .bottomToTop: .topToBottom
        }
    }
    
    /// Indicates if layout direction is reversed, such as `bottomToTop`.
    public var isReversed: Bool {
        switch self {
        case .topToBottom: false
        case .bottomToTop: true
        }
    }
    
    // MARK: SwiftUI
    /// Alignment.
    public var alignment: Alignment {
        switch self {
        case .topToBottom: .top
        case .bottomToTop: .bottom
        }
    }
    
    /// Edge.
    public var edge: Edge {
        switch self {
        case .topToBottom: .top
        case .bottomToTop: .bottom
        }
    }
    
    /// Edge.Set.
    public var edgeSet: Edge {
        switch self {
        case .topToBottom: .top
        case .bottomToTop: .bottom
        }
    }
}
