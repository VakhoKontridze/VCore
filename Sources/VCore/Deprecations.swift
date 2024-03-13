//
//  Deprecations.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import SwiftUI

// MARK: - KeyPath Initializable Enumeration
extension KeyPathInitializableEnumeration {
    @available(*, deprecated, message: "Use initializer instead")
    public static func aCase<Property>(
        key keyPath: KeyPath<Self, Property>,
        value: Property
    ) -> Self?
        where Property: Equatable
    {
        Self.allCases.first { $0[keyPath: keyPath] == value }
    }
}

// MARK: - Uninitializable Macro
@available(*, deprecated, renamed: "Uninitializable")
@attached(member, names: named(init))
public macro NonInitializable() = #externalMacro(
    module: "VCoreMacros",
    type: "UninitializableMacro"
)
