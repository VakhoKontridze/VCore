//
//  String+RemovingReservedKeywordBackticks.swift
//  VCoreMacrosImplementation
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

import Foundation
import VCoreShared

extension String {
    func removingReservedKeywordBackticks() -> String {
        _removing(CharacterSet(arrayLiteral: "`"))
    }
}
