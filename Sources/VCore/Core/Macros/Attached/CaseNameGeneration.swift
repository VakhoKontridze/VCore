//
//  CaseNameGeneration.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28/4/26.
//

import Foundation

/// Adds `CaseName` `enum` and helper methods to a declaration.
///
/// If `accessLevelModifier` is `nil`, it will be inherited from the type.
///
///     @CaseNameGeneration
///     nonisolated enum ImageCacheEntry {
///         case inProgress(Task<UIImage, any Error>)
///         case completed(UIImage)
///     }
///
///     // Generates
///     internal func toName() -> Name {
///         switch self {
///         case .inProgress: .inProgress
///         case .completed: .completed
///         }
///     }
///
///     internal func `is`(_ name: Name) -> Bool {
///         toName() == name
///     }
///
///     nonisolated internal enum Name: CaseIterable {
///         case inProgress
///         case completed
///     }
///
@attached(member, names: arbitrary)
public macro CaseNameGeneration(
    accessLevelModifier: AccessLevelModifierKeyword? = nil
) = #externalMacro(
    module: "VCoreMacrosImplementation",
    type: "CaseNameGenerationMacro"
)
