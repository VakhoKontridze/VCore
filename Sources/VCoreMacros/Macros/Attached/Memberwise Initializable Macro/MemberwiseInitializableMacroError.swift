//
//  MemberwiseInitializableMacroError.swift
//  VCoreMacros
//
//  Created by Vakhtang Kontridze on 22.05.24.
//

import Foundation

// MARK: - Memberwise Initializable Macro Error
struct MemberwiseInitializableMacroError: Error, CustomStringConvertible {
    // MARK: Properties
    let description: String

    // MARK: Initializers
    private init(
        _ description: String
    ) {
        self.description = description
    }

    static var cannotBeAppliedToEnums: Self { .init("'MemberwiseInitializable' macro cannot be applied to 'enum's") }
    static var invalidAccessLevelModifierParameter: Self { .init("Invalid 'accessLevelModifier' parameter") }
    static var invalidExternalParameterNamesParameter: Self { .init("Invalid 'externalParameterNames' parameter") }
    static var invalidParameterDefaultValuesParameter: Self { .init("Invalid 'parameterDefaultValues' parameter") }
    static var invalidExcludedParametersParameter: Self { .init("Invalid 'excludedParameters' parameter") }
    static var onePropertyAllowedPerLine: Self { .init("Only one property declaration is allowed per line") }
    static var invalidPropertyType: Self { .init("Invalid property type") }
}
