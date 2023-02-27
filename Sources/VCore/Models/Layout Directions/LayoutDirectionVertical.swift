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
public enum LayoutDirectionVertical: Hashable, CaseIterable {
    // MARK: Cases
    /// Bottom-to-top direction.
    case topToBottom
    
    /// Top-to-bottom direction.
    case bottomToTop
    
    // MARK: Properties
    /// Indicates if layout direction is reversed, such as `bottomToTop`.
    public var isReversed: Bool {
        switch self {
        case .topToBottom: return false
        case .bottomToTop: return true
        }
    }
}
