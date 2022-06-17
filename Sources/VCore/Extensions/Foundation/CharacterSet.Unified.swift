//
//  CharacterSet.Unified.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.06.22.
//

import Foundation

// MARK: - Character Set Unified
extension Array where Element == CharacterSet {
    /// Returns a union of the CharacterSet `Array`'s.
    ///
    ///     let unifiedCharacterSet: CharacterSet = [.decimalDigits, .letters, .symbols].unified
    ///
    public var unified: CharacterSet {
        reduce(CharacterSet(), { $0.union($1) })
    }
}
