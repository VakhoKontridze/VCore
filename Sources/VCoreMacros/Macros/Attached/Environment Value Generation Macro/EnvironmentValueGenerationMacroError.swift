//
//  EnvironmentValueGenerationMacroError.swift
//  VCoreMacros
//
//  Created by Vakhtang Kontridze on 19.04.24.
//

import Foundation

// MARK: - Environment Value Generation Macro Error
struct EnvironmentValueGenerationMacroError: Error, CustomStringConvertible {
    // MARK: Properties
    let description: String

    // MARK: Initializers
    private init(
        _ description: String
    ) {
        self.description = description
    }

    static var canOnlyBeAppliedToProperties: Self { .init("'EnvironmentValueGeneration' macro can only be applied to a properties") }
    static var canOnlyBeAppliedToVariableProperties: Self { .init("'EnvironmentValueGeneration' macro can only be applied to variable properties") }
    static var invalidPropertyName: Self { .init("Invalid property name") }
    static var invalidPropertyType: Self { .init("Invalid property type") }
    static var invalidDefaultValue: Self { .init("Invalid default value") }
}
