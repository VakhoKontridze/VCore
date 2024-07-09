//
//  TextLineType.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 17.08.22.
//

import SwiftUI

// MARK: - Text Line Type
/// Model that represents text line, such as `singleLine` or `multiLine`.
public struct TextLineType {
    // MARK: Properties
    private let storage: Storage
    
    /// `TextAlignment`.
    public var textAlignment: TextAlignment? {
        switch storage {
        case .singleLine: nil
        case .multiLine(let alignment, _): alignment
        }
    }
    
    /// `TextLineLimitType`.
    public var textLineLimitType: TextLineLimitType {
        switch storage {
        case .singleLine: .fixed(lineLimit: 1)
        case .multiLine(_, let textLineLimitType): textLineLimitType
        }
    }
    
    // MARK: Initializers
    private init(
        _ storage: Storage
    ) {
        self.storage = storage
    }
    
    /// Single-line.
    public static var singleLine: Self {
        .init(.singleLine)
    }
    
    /// Multi-line.
    public static func multiLine(
        alignment: TextAlignment,
        lineLimit: Int?
    ) -> Self {
        .init(
            .multiLine(
                alignment: alignment,
                textLineLimitType: .fixed(lineLimit: lineLimit)
            )
        )
    }
    
    /// Multi-line.
    public static func multiLine(
        alignment: TextAlignment,
        lineLimit: Int,
        reservesSpace: Bool
    ) -> Self {
        .init(
            .multiLine(
                alignment: alignment,
                textLineLimitType: .spaceReserved(lineLimit: lineLimit, reservesSpace: reservesSpace)
            )
        )
    }

    /// Multi-line.
    public static func multiLine(
        alignment: TextAlignment,
        lineLimit: PartialRangeThrough<Int>
    ) -> Self {
        .init(
            .multiLine(
                alignment: alignment,
                textLineLimitType: .partialRangeThrough(lineLimit: lineLimit)
            )
        )
    }

    /// Multi-line.
    public static func multiLine(
        alignment: TextAlignment,
        lineLimit: PartialRangeFrom<Int>
    ) -> Self {
        .init(
            .multiLine(
                alignment: alignment,
                textLineLimitType: .partialRangeFrom(lineLimit: lineLimit)
            )
        )
    }

    /// Multi-line.
    public static func multiLine(
        alignment: TextAlignment,
        lineLimit: ClosedRange<Int>
    ) -> Self {
        .init(
            .multiLine(
                alignment: alignment,
                textLineLimitType: .closedRange(lineLimit: lineLimit)
            )
        )
    }

    // MARK: Storage
    enum Storage {
        case singleLine
        case multiLine(alignment: TextAlignment, textLineLimitType: TextLineLimitType)
    }
}
