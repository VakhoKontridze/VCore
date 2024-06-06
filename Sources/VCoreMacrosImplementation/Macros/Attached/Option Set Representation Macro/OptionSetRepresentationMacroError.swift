//
//  OptionSetRepresentationMacroError.swift
//  VCoreMacrosImplementation
//
//  Created by Vakhtang Kontridze on 02.03.24.
//

import Foundation

// MARK: - Option Set Representation Macro Error
struct OptionSetRepresentationMacroError: Error, CustomStringConvertible {
    // MARK: Properties
    let description: String

    // MARK: Initializers
    private init(
        _ description: String
    ) {
        self.description = description
    }

    static var invalidAccessLevelModifierParameter: Self { .init("Invalid 'accessLevelModifier' parameter") }
    static var canOnlyBeAppliedToStructs: Self { .init("'OptionSetRepresentation' macro can only be applied to 'struct's") }
    static var optionsEnumNotFound: Self { .init("Options 'enum' not found") }
    static var optionsEnumRawTypeNotDeclared: Self { .init("Options 'enum' must conform to a raw type") }
}
