//
//  RunBlockNTimes.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/12/21.
//

import Foundation

// MARK: - Run Block n Times
extension Int {
    /// Runs block by specified times
    public func times(_ block: () -> Void) {
        times { _ in block() }
    }
    
    /// Runs block by specified times, and passes index as parameters
    public func times(_ block: (Int) -> Void) {
        guard self > 0 else { return }
        for i in 0..<self { block(i) }
    }
}
