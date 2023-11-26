//
//  Int.RunBlockNTimes.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/12/21.
//

import Foundation

// MARK: - Int Run Block "n" Times
extension Int {
    /// Runs block by specified times.
    ///
    ///     5.times { print("Hello, World!") }
    ///
    public func times(
        _ block: () throws -> Void
    ) rethrows {
        guard self > 0 else { return }

        for _ in 0..<self { try block() }
    }
    
    /// Runs block by specified times, and passes index as parameters.
    ///
    ///     5.times { i in print("Hello, World \(i)!") }
    ///
    public func times(
        _ block: (Int) throws -> Void
    ) rethrows {
        guard self > 0 else { return }
        
        for i in 0..<self { try block(i) }
    }
}
