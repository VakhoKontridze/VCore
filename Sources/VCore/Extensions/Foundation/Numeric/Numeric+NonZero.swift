//
//  Numeric+NonZero.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 26.11.23.
//

import Foundation

// MARK: - Numeric + Non-Zero
extension Numeric {
    /// Returns non-zero sized `Numeric`, or `nil`.
    ///
    ///     let number1: Int? = 0.nonZero // nil
    ///     let number2: Int? = 1.nonZero // 1
    ///
    public var nonZero: Self? {
        guard self != 0 else { return nil }
        return self
    }
}
