//
//  Range+InitWithBounds.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.07.23.
//

import Foundation

// MARK: - Range + Init with Bounds
extension Range {
    /// Initializes `Range` with lower and upper bounds.
    ///
    ///     let range: Range<Int> = .init(lower: 1, upper: 10)
    ///
    public init(lower: Bound, upper: Bound) {
        self = lower..<upper
    }
}
