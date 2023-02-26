//
//  OmniLayoutDirection.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 26.02.23.
//

import SwiftUI

// MARK: - Omni Layout Direction
/// Omni-directional layout in which content can be laid out.
///
/// Unlike `SwiftUI.LayoutDirection`, `OmniLayoutDirection` also supports vertical layouts.
public enum OmniLayoutDirection: Hashable, CaseIterable {
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
        case .leftToRight: return true
        case .rightToLeft: return true
        case .topToBottom: return false
        case .bottomToTop: return false
        }
    }
    
    /// Indicates if layout direction is vertical.
    public var isVertical: Bool {
        !isHorizontal
    }
    
    /// Indicates if layout direction is reversed, such as `rightToLeft` or `bottomToTop`.
    public var isReversed: Bool {
        switch self {
        case .leftToRight: return false
        case .rightToLeft: return true
        case .topToBottom: return false
        case .bottomToTop: return true
        }
    }
    
    // MARK: Methods
    /// Creates stack `Layout` based on axis of direction.
    ///
    /// For `leftToRight` or `rightToLeft`, `HStackLayout` will be used.
    /// For `topToBottom` or `bottomToTop`, `VStackLayout` will be used.
    @available(iOS 16.0, *)
    @available(macOS 13.0, *)
    @available(tvOS 16.0, *)
    @available(watchOS 9.0, *)
    public func stackLayout(
        alignmentHor: HorizontalAlignment = .center,
        alignmentVer: VerticalAlignment = .center,
        spacing: CGFloat? = nil
    ) -> AnyLayout {
        if isHorizontal {
            return .init(HStackLayout(
                alignment: alignmentVer,
                spacing: spacing
            ))
            
        } else {
            return .init(VStackLayout(
                alignment: alignmentHor,
                spacing: spacing
            ))
        }
    }
}
