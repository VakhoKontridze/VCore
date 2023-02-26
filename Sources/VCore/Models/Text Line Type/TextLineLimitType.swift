//
//  TextLineLimitType.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 14.08.22.
//

import SwiftUI

// MARK: - View Line Limit
@available(iOS 16.0, *)
@available(macOS 13.0, *)
@available(tvOS 16.0, *)
@available(watchOS 9.0, *)
extension View {
    /// Sets line limit based on `TextLineLimitType`.
    ///
    ///     var body: some View {
    ///         Text("Lorem ipsum")
    ///             .lineLimit(type: .closedRange(lineLimit: 4...5))
    ///     }
    ///
    @ViewBuilder public func lineLimit(
        type textLineLimitType: TextLineLimitType
    ) -> some View {
        switch textLineLimitType {
        case .none:
            self
            
        case .fixed(let lineLimit):
            self
                .lineLimit(lineLimit)
            
        case .spaceReserved(let lineLimit, let reservesSpace):
            self
                .lineLimit(lineLimit, reservesSpace: reservesSpace)
            
        case .partialRangeFrom(let lineLimit):
            self
                .lineLimit(lineLimit)
            
        case .partialRangeThrough(let lineLimit):
            self
                .lineLimit(lineLimit)
            
        case .closedRange(let lineLimit):
            self
                .lineLimit(lineLimit)
        }
    }
}

// MARK: - Text Line Limit Type
/// Enumeration that represents line limit type.
@available(iOS 16.0, *)
@available(macOS 13.0, *)
@available(tvOS 16.0, *)
@available(watchOS 9.0, *)
public enum TextLineLimitType {
    /// No line limit.
    case none
    
    /// Fixed line limit.
    case fixed(lineLimit: Int?)
    
    /// Fixed line limit with reserved space.
    case spaceReserved(lineLimit: Int, reservesSpace: Bool)
    
    /// Partial range (from) line limit.
    case partialRangeFrom(lineLimit: PartialRangeFrom<Int>)
    
    /// Partial range (though) line limit.
    case partialRangeThrough(lineLimit: PartialRangeThrough<Int>)
    
    /// Closed range line limit.
    case closedRange(lineLimit: ClosedRange<Int>)
}
