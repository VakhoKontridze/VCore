//
//  DynamicTypeSizeType.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 09.07.24.
//

import SwiftUI

// MARK: - Dynamic Type Size Type
/// Model that represents `DynamicTypeSize`.
public struct DynamicTypeSizeType: Sendable {
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

    // MARK: Storage
    enum Storage {
        case fixed(size: DynamicTypeSize)
        case partialRangeUpTo(range: PartialRangeUpTo<DynamicTypeSize>)
        case partialRangeThrough(range: PartialRangeThrough<DynamicTypeSize>)
        case partialRangeFrom(range: PartialRangeFrom<DynamicTypeSize>)
        case range(range: Range<DynamicTypeSize>)
        case closedRange(range: ClosedRange<DynamicTypeSize>)
    }
}
