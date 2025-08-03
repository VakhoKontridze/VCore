//
//  TextLineLimitType.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 14.08.22.
//

import SwiftUI

/// Model that represents line limit type.
public struct TextLineLimitType: Equatable, Sendable {
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
    enum Storage: Equatable {
        // MARK: Cases
        case none
        case fixed(lineLimit: Int?)
        case fixedSpaceReserved(lineLimit: Int, reservesSpace: Bool)
        //case partialRangeUpTo(range: PartialRangeUpTo<Int>) // Not supported natively
        case partialRangeThrough(range: PartialRangeThrough<Int>)
        case partialRangeFrom(range: PartialRangeFrom<Int>)
        //case range(range: Range<Int>) // Not supported natively
        case closedRange(range: ClosedRange<Int>)
        
        // MARK: Equatable
        static func == (lhs: Self, rhs: Self) -> Bool {
            switch (lhs, rhs) {
            case (.none, .none):
                true
                
            case (.fixed(let lhs), .fixed(let rhs)):
                lhs == rhs
            
            case (.fixedSpaceReserved(let lhsLimit, let lhsReserves), .fixedSpaceReserved(let rhsLimit, let rhsReserves)):
                lhsLimit == rhsLimit &&
                lhsReserves == rhsReserves
            
            case (.partialRangeThrough(let lhs), .partialRangeThrough(let rhs)):
                lhs.upperBound == rhs.upperBound
            
            case (.partialRangeFrom(let lhs), .partialRangeFrom(let rhs)):
                lhs.lowerBound == rhs.lowerBound
            
            case (.closedRange(let lhs), .closedRange(let rhs)):
                lhs == rhs
            
            default:
                false
            }
        }
    }
}
