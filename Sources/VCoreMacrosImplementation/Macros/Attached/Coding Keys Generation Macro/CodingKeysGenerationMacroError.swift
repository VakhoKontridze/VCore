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
    static var canOnlyBeAppliedToVariables: Self { .init("'CKGProperty' macro can only be applied to variables") }
    static var onePropertyAllowedPerLine: Self { .init("Only one property declaration is allowed per line") }
    static var cannotBeAppliedToComputedProperties: Self { .init("'CKGProperty' macro can not be applied to computed properties") }
    static var invalidPropertyName: Self { .init("Invalid property name") }
    static var invalidKey: Self { .init("Invalid key") }
}
