//
//  TextLineLimitType.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 14.08.22.
//

import SwiftUI

// MARK: - View Line Limit
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension View {
    /// Sets line limit based on `TextLineLimitType`.
    ///
    ///     var body: some View {
    ///         Text("Lorem ipsum")
    ///             .lineLimit(type: .closedRange(lineLimit: 4...5))
    ///     }
    ///
    public func lineLimit(type: TextLineLimitType) -> some View {
        self
            .modifier(TextLineLimitViewModifier(type: type))
    }
}

// MARK: - Text Line Limit Type
/// Enumeration that represents line limit type.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
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

// MARK: - Text Line Limit View Modifier
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
private struct TextLineLimitViewModifier: ViewModifier {
    // MARK: Properties
    private let textLineLimitType: TextLineLimitType
    
    // MARK: Initializers
    init(type textLineLimitType: TextLineLimitType) {
        self.textLineLimitType = textLineLimitType
    }
    
    // MARK: Body
    func body(content: Content) -> some View {
        switch textLineLimitType {
        case .none:
            content
            
        case .fixed(let lineLimit):
            content
                .lineLimit(lineLimit)
            
        case .spaceReserved(let lineLimit, let reservesSpace):
            content
                .lineLimit(lineLimit, reservesSpace: reservesSpace)
            
        case .partialRangeFrom(let lineLimit):
            content
                .lineLimit(lineLimit)
            
        case .partialRangeThrough(let lineLimit):
            content
                .lineLimit(lineLimit)
            
        case .closedRange(let lineLimit):
            content
                .lineLimit(lineLimit)
        }
    }
}
