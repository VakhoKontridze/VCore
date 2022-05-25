//
//  KVInitializableEnumeration.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/9/21.
//

import Foundation

// MARK: - Key-Value Initializable Enumeration
/// KeyPath Initializable Enumeration.
///
/// Enumeration that allows for dynamic lookup of a case witha given property keupath and value.
///
///     enum SomeEnum: KVInitializableEnumeration {
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
///     let value: SomeEnum? = .aCase(key: \.someProperty, value: 2)
///
public protocol KVInitializableEnumeration: CaseIterable {
    static func aCase<Property>(
        key keyPath: KeyPath<Self, Property>,
        value: Property
    ) -> Self?
        where Property: Equatable
}

extension KVInitializableEnumeration {
    public static func aCase<Property>(
        key keyPath: KeyPath<Self, Property>,
        value: Property
    ) -> Self?
        where Property: Equatable
    {
        Self.allCases.first(where: { $0[keyPath: keyPath] == value })
    }
}
