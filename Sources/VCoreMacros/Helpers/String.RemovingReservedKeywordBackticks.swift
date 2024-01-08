//
//  String.RemovingReservedKeywordBackticks.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

import Foundation

// MARK: - String Removing Reserved Keyword Backticks
extension String {
    func removingReservedKeywordBackticks() -> String {
        removing(CharacterSet(arrayLiteral: "`"))
    }
}

// MARK: - Helpers
extension String {
    // From `VCore`
    fileprivate func removing(_ characterSet: CharacterSet) -> String {
        filter { char in
            guard let unicodeScalar: Unicode.Scalar = char.unicodeScalars.first else { return false }
            return !characterSet.contains(unicodeScalar)
        }
    }
}
