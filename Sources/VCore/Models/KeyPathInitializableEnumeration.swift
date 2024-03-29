//
//  KeyPathInitializableEnumeration.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/9/21.
//

import Foundation

// MARK: - KeyPath Initializable Enumeration
/// Enumeration that allows for dynamic lookup of a case with a given property `KeyPath` and value.
///
///     enum SomeEnum: KeyPathInitializableEnumeration {
///         case first
///         case second
///
///         var someProperty: Int {
///             switch self {
///             case .first: 1
///             case .second: 2
///             }
///         }
///     }
///
///     let value: SomeEnum? = .aCase(key: \.someProperty, value: 2)
///
public protocol KeyPathInitializableEnumeration: CaseIterable {
    static func aCase<Property>(
        key keyPath: KeyPath<Self, Property>,
        value: Property
    ) -> Self?
        where Property: Equatable
}

extension KeyPathInitializableEnumeration {
    public static func aCase<Property>(
        key keyPath: KeyPath<Self, Property>,
        value: Property
    ) -> Self?
        where Property: Equatable
    {
        Self.allCases.first { $0[keyPath: keyPath] == value }
    }
}
