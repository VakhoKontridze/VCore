//
//  TextLineLimitType.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 14.08.22.
//

import SwiftUI

// MARK: - View Line Limit
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
        switch textLineLimitType._textLineLimitType {
        case .none:
            self
            
        case .fixed(let lineLimit):
            self
                .lineLimit(lineLimit)
            
        case .spaceReserved(let lineLimit, let reservesSpace):
            if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
                self
                    .lineLimit(lineLimit, reservesSpace: reservesSpace)
            } else {
                fatalError()
            }
            
        case .partialRangeFrom(let lineLimit):
            if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
                self
                    .lineLimit(lineLimit)
            } else {
                fatalError()
            }
            
        case .partialRangeThrough(let lineLimit):
            if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
                self
                    .lineLimit(lineLimit)
            } else {
                fatalError()
            }
            
        case .closedRange(let lineLimit):
            if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
                self
                    .lineLimit(lineLimit)
            } else {
                fatalError()
            }
        }
    }
}

// MARK: - Text Line Limit Type
/// Model that represents line limit type.
public struct TextLineLimitType {
    // MARK: Properties
    let _textLineLimitType: _TextLineLimitType
    
    // MARK: Initializers
    private init(
        textLineLimitType: _TextLineLimitType
    ) {
        self._textLineLimitType = textLineLimitType
    }
    
    /// No line limit.
    public static var none: Self {
        .init(textLineLimitType: .none)
    }
    
    /// Fixed line limit.
    public static func fixed(lineLimit: Int?) -> Self {
        .init(textLineLimitType: .fixed(
            lineLimit: lineLimit
        ))
    }
    
    /// Fixed line limit with reserved space.
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    public static func spaceReserved(lineLimit: Int, reservesSpace: Bool) -> Self {
        .init(textLineLimitType: .spaceReserved(
            lineLimit: lineLimit,
            reservesSpace: reservesSpace
        ))
    }
    
    /// Partial range (from) line limit.
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    public static func partialRangeFrom(lineLimit: PartialRangeFrom<Int>) -> Self {
        .init(textLineLimitType: .partialRangeFrom(
            lineLimit: lineLimit
        ))
    }
    
    /// Partial range (though) line limit.
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    public static func partialRangeThrough(lineLimit: PartialRangeThrough<Int>) -> Self {
        .init(textLineLimitType: .partialRangeThrough(
            lineLimit: lineLimit
        ))
    }
    
    /// Closed range line limit.
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    public static func closedRange(lineLimit: ClosedRange<Int>) -> Self {
        .init(textLineLimitType: .closedRange(
            lineLimit: lineLimit
        ))
    }
}

// MARK: - _ Text Line Limit Type
enum _TextLineLimitType {
    case none
    case fixed(lineLimit: Int?)
    case spaceReserved(lineLimit: Int, reservesSpace: Bool)
    case partialRangeFrom(lineLimit: PartialRangeFrom<Int>)
    case partialRangeThrough(lineLimit: PartialRangeThrough<Int>)
    case closedRange(lineLimit: ClosedRange<Int>)
}
