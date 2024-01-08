//
//  String.RemovingReservedKeywordBackticks.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

import Foundation
import VCoreShared

// MARK: - String Removing Reserved Keyword Backticks
extension String {
    func removingReservedKeywordBackticks() -> String {
        _removing(CharacterSet(arrayLiteral: "`"))
    }
}
