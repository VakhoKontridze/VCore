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
    public static func fixed(
        lineLimit: Int?
    ) -> Self {
        .init(
            .fixed(
                lineLimit: lineLimit
            )
        )
    }
    
    /// Fixed line limit with reserved space.
    public static func spaceReserved(
        lineLimit: Int,
        reservesSpace: Bool
    ) -> Self {
        .init(
            .spaceReserved(
                lineLimit: lineLimit,
                reservesSpace: reservesSpace
            )
        )
    }
    
    /// Partial range (through) line limit.
    public static func partialRangeThrough(
        lineLimit: PartialRangeThrough<Int>
    ) -> Self {
        .init(
            .partialRangeThrough(
                lineLimit: lineLimit
            )
        )
    }

    /// Partial range (from) line limit.
    public static func partialRangeFrom(
        lineLimit: PartialRangeFrom<Int>
    ) -> Self {
        .init(
            .partialRangeFrom(
                lineLimit: lineLimit
            )
        )
    }

    /// Closed range line limit.
    public static func closedRange(
        lineLimit: ClosedRange<Int>
    ) -> Self {
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
        //case partialRangeUpTo(lineLimit: PartialRangeUpTo<Int>) // Not supported natively
        case partialRangeThrough(lineLimit: PartialRangeThrough<Int>)
        case partialRangeFrom(lineLimit: PartialRangeFrom<Int>)
        //case range(lineLimit: Range<Int>) // Not supported natively
        case closedRange(lineLimit: ClosedRange<Int>)
    }
}
