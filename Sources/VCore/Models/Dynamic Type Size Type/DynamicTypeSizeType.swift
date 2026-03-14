//
//  DynamicTypeSizeType.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 09.07.24.
//

import SwiftUI

/// Model that represents `DynamicTypeSize`.
public nonisolated struct DynamicTypeSizeType: Equatable, Sendable {
    // MARK: Properties
    let storage: Storage

    // MARK: Initializers
    private init(
        _ storage: Storage
    ) {
        self.storage = storage
    }

    /// Fixed `DynamicTypeSize`.
    public static func fixed(
        _ size: DynamicTypeSize
    ) -> Self {
        self.init(
            .fixed(
                size: size
            )
        )
    }

    /// Partial range (up to) `DynamicTypeSize`.
    public static func partialRangeUpTo(
        _ range: PartialRangeUpTo<DynamicTypeSize>
    ) -> Self {
        self.init(
            .partialRangeUpTo(
                range: range
            )
        )
    }

    /// Partial range (through) `DynamicTypeSize`.
    public static func partialRangeThrough(
        _ range: PartialRangeThrough<DynamicTypeSize>
    ) -> Self {
        self.init(
            .partialRangeThrough(
                range: range
            )
        )
    }

    /// Partial range (from) `DynamicTypeSize`.
    public static func partialRangeFrom(
        _ range: PartialRangeFrom<DynamicTypeSize>
    ) -> Self {
        self.init(
            .partialRangeFrom(
                range: range
            )
        )
    }

    /// Range `DynamicTypeSize`.
    public static func range(
        _ range: Range<DynamicTypeSize>
    ) -> Self {
        self.init(
            .range(
                range: range
            )
        )
    }

    /// Closed range `DynamicTypeSize`.
    public static func closedRange(
        _ range: ClosedRange<DynamicTypeSize>
    ) -> Self {
        self.init(
            .closedRange(
                range: range
            )
        )
    }

    // MARK: Types
    nonisolated enum Storage: Equatable {
        // MARK: Cases
        case fixed(size: DynamicTypeSize)
        case partialRangeUpTo(range: PartialRangeUpTo<DynamicTypeSize>)
        case partialRangeThrough(range: PartialRangeThrough<DynamicTypeSize>)
        case partialRangeFrom(range: PartialRangeFrom<DynamicTypeSize>)
        case range(range: Range<DynamicTypeSize>)
        case closedRange(range: ClosedRange<DynamicTypeSize>)
        
        // MARK: Equatable
        static func == (lhs: Self, rhs: Self) -> Bool {
            switch (lhs, rhs) {
            case (.fixed(let lhsSize), .fixed(let rhsSize)):
                lhsSize == rhsSize
                
            case (.partialRangeUpTo(let lhs), .partialRangeUpTo(let rhs)):
                lhs.upperBound == rhs.upperBound
                
            case (.partialRangeThrough(let lhs), .partialRangeThrough(let rhs)):
                lhs.upperBound == rhs.upperBound
                
            case (.partialRangeFrom(let lhs), .partialRangeFrom(let rhs)):
                lhs.lowerBound == rhs.lowerBound
                
            case (.range(let lhs), .range(let rhs)):
                lhs.lowerBound == rhs.lowerBound &&
                lhs.upperBound == rhs.upperBound
                
            case (.closedRange(let lhs), .closedRange(let rhs)):
                lhs == rhs
                
            default:
                false
            }
        }
    }
}
