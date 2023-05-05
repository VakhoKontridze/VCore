//
//  Array.SafeSubscript.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/12/21.
//

import Foundation

// MARK: - Safe Array Subscript
extension Array {
    /// Accesses the element at the specified position, but returns `nil` if out of bounds.
    ///
    ///     let numbers: [Int] = [1, 3, 5]
    ///
    ///     let firstNum: Int? = numbers[safe: 0] // 1
    ///     let fourthNum: Int? = numbers[safe: 4] // nil
    ///
    public subscript(safe index: Int) -> Element? {
        guard index >= 0, index < count else { return nil }
        return self[index]
    }
}
