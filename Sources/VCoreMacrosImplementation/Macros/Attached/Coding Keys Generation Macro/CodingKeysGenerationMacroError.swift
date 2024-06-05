//
//  CodingKeysGenerationMacroError.swift
//  VCoreMacrosImplementation
//
//  Created by Vakhtang Kontridze on 02.03.24.
//

import Foundation

// MARK: - Coding Keys Generation Macro Error
struct CodingKeysGenerationMacroError: Error, CustomStringConvertible {
    // MARK: Properties
    let description: String

    // MARK: Initializers
    private init(
        _ description: String
    ) {
        self.description = description
    }

    static var invalidAccessLevelModifierParameter: Self { .init("Invalid 'accessLevelModifier' parameter") }
    static var onePropertyAllowedPerLine: Self { .init("Only one property declaration is allowed per line") }
    static var invalidPropertyName: Self { .init("Invalid property name") }
    static var invalidKeyName: Self { .init("Invalid key name") }
}
