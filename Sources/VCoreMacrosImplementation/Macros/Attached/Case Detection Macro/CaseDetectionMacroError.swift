//
//  CaseDetectionMacroError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.03.24.
//

import Foundation

// MARK: - Case Detection Macro Error
struct CaseDetectionMacroError: Error, CustomStringConvertible {
    // MARK: Properties
    let description: String

    // MARK: Initializers
    private init(
        _ description: String
    ) {
        self.description = description
    }

    static var invalidAccessLevelModifierParameter: Self { .init("Invalid 'accessLevelModifier' parameter") }
    static var canOnlyBeAppliedToEnums: Self { .init("'CaseDetection' macro can only be applied to 'enum's") }
}
