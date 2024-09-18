//
//  OptionSetRepresentation.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

import Foundation

// MARK: - Option Set Representation
/// Adds an `OptionSet` from `struct` that contains a nested `Options` `enum`.
///
/// If `accessLevelModifier` is `nil`, it will be inherited from the type.
///
/// If type is `public`, `Sendable` conformance must be added.
///
///     @OptionSetRepresentation<Int>
///     struct Gender {
///         private enum Options: Int {
///             case male
///             case female
///         }
///     }
///
///     let genders: Gender = [...]
///
///     if genders.contains(.male) {
///         // ...
///     }
///
@attached(member, names: arbitrary)
@attached(extension, conformances: OptionSet)
public macro OptionSetRepresentation<RawType>(
    accessLevelModifier: AccessLevelModifierKeyword? = nil
) = #externalMacro(
    module: "VCoreMacrosImplementation",
    type: "OptionSetRepresentationMacro"
)
