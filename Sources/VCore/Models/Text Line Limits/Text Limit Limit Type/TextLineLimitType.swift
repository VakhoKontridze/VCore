//
//  TextLineLimitType.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 14.08.22.
//

import SwiftUI

// MARK: - Text Line Limit Type
/// Model that represents line limit type.
public struct TextLineLimitType: Sendable {
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
    public static func fixed(
        _ lineLimit: Int?
    ) -> Self {
        .init(
            .fixed(
                lineLimit: lineLimit
            )
        )
    }
    
    /// Fixed line limit with reserved space.
    public static func fixed(
        _ lineLimit: Int,
        reservesSpace: Bool
    ) -> Self {
        .init(
            .fixedSpaceReserved(
                lineLimit: lineLimit,
                reservesSpace: reservesSpace
            )
        )
    }
    
    /// Partial range (through) line limit.
    public static func partialRangeThrough(
        _ range: PartialRangeThrough<Int>
    ) -> Self {
        .init(
            .partialRangeThrough(
                range: range
            )
        )
    }

    /// Partial range (from) line limit.
    public static func partialRangeFrom(
        _ range: PartialRangeFrom<Int>
    ) -> Self {
        .init(
            .partialRangeFrom(
                range: range
            )
        )
    }

    /// Closed range line limit.
    public static func closedRange(
        _ range: ClosedRange<Int>
    ) -> Self {
        .init(
            .closedRange(
                range: range
            )
        )
    }

    // MARK: Storage
    enum Storage {
        case none
        case fixed(lineLimit: Int?)
        case fixedSpaceReserved(lineLimit: Int, reservesSpace: Bool)
        //case partialRangeUpTo(range: PartialRangeUpTo<Int>) // Not supported natively
        case partialRangeThrough(range: PartialRangeThrough<Int>)
        case partialRangeFrom(range: PartialRangeFrom<Int>)
        //case range(range: Range<Int>) // Not supported natively
        case closedRange(range: ClosedRange<Int>)
    }
}
