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
///     let value: SomeEnum? = .init(key: \.someProperty, value: 2)
///
public protocol KeyPathInitializableEnumeration: CaseIterable {
    init?<Property>(
        key keyPath: KeyPath<Self, Property>,
        value: Property
    )
        where Property: Equatable
}

extension KeyPathInitializableEnumeration {
    public init?<Property>(
        key keyPath: KeyPath<Self, Property>,
        value: Property
    ) 
        where Property: Equatable
    {
        guard 
            let aCase: Self = .allCases.first(where: { $0[keyPath: keyPath] == value })
        else {
            return nil
        }

        self = aCase
    }
}
