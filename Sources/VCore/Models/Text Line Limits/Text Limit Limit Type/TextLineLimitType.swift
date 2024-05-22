//
//  TextLineLimitType.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 14.08.22.
//

import SwiftUI

// MARK: - Text Line Limit Type
/// Model that represents line limit type.
public struct TextLineLimitType {
    // MARK: Properties
    let storage: Storage
    
    // MARK: Initializers
    private init(
        _ storage: Storage
    ) {
        self.storage = storage
    }
    
    /// No line limit.
    public static var none: Self {
        .init(.none)
    }
    
    /// Fixed line limit.
    public static func fixed(lineLimit: Int?) -> Self {
        .init(
            .fixed(
                lineLimit: lineLimit
            )
        )
    }
    
    /// Fixed line limit with reserved space.
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    public static func spaceReserved(lineLimit: Int, reservesSpace: Bool) -> Self {
        .init(
            .spaceReserved(
                lineLimit: lineLimit,
                reservesSpace: reservesSpace
            )
        )
    }
    
    /// Partial range (from) line limit.
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    public static func partialRangeFrom(lineLimit: PartialRangeFrom<Int>) -> Self {
        .init(
            .partialRangeFrom(
                lineLimit: lineLimit
            )
        )
    }
    
    /// Partial range (though) line limit.
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    public static func partialRangeThrough(lineLimit: PartialRangeThrough<Int>) -> Self {
        .init(
            .partialRangeThrough(
                lineLimit: lineLimit
            )
        )
    }
    
    /// Closed range line limit.
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    public static func closedRange(lineLimit: ClosedRange<Int>) -> Self {
        .init(
            .closedRange(
                lineLimit: lineLimit
            )
        )
    }

    // MARK: Storage
    enum Storage {
        case none
        case fixed(lineLimit: Int?)
        case spaceReserved(lineLimit: Int, reservesSpace: Bool)
        case partialRangeFrom(lineLimit: PartialRangeFrom<Int>)
        case partialRangeThrough(lineLimit: PartialRangeThrough<Int>)
        case closedRange(lineLimit: ClosedRange<Int>)
    }
}
