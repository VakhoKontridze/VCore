//
//  ClosedRange.InitWithBounds.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 05.08.23.
//

import Foundation

// MARK: - ClosedRange Init with Bounds
extension ClosedRange {
    /// Initializes `ClosedRange` with lower and upper bounds.
    ///
    ///     let range: ClosedRange<Int> = .init(lower: 1, upper: 10)
    ///
    public init(lower: Bound, upper: Bound) {
        self = lower...upper
    }
}
