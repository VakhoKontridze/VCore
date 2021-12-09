//
//  KeyPathInitializableEnumeration.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/9/21.
//

import Foundation

// MARK: - Keypath Initializable Enumeration
/// KeyPath Initializable Enumeration.
///
/// Enumeration that allows for dynamic lookup of a case witha given property keupath and value.
///
/// Usage example:
///
///     enum SomeEnum: KeyPathInitializableEnumeration {
///         case first
///         case second
///
///         var someProperty: Int {
///             switch self {
///             case .first: return 1
///             case .second: return 2
///             }
///         }
///     }
///
///     let value: SomeEnum? = .aCase(with: 2, for: \.someProperty)
///
public protocol KeyPathInitializableEnumeration: CaseIterable {
    static func aCase <Property>(
        with value: Property,
        for keyPath: KeyPath<Self, Property>
    ) -> Self?
        where Property: Equatable
}

extension KeyPathInitializableEnumeration {
    public static func aCase <Property>(
        with value: Property,
        for keyPath: KeyPath<Self, Property>
    ) -> Self?
        where Property: Equatable
    {
        Self.allCases.first(where: { $0[keyPath: keyPath] == value })
    }
}
