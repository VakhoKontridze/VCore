//
//  CaseIterable+InitithKeyAndValue.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/9/21.
//

import Foundation

extension CaseIterable {
    /// Initializes an enumeration with a given property `KeyPath` and value.
    ///
    ///     enum Gender: CaseIterable {
    ///         case male
    ///         case female
    ///
    ///         var id: Int {
    ///             switch self {
    ///             case .male: 1
    ///             case .female: 2
    ///             }
    ///         }
    ///     }
    ///
    ///     let gender: Gender? = .init(key: \.id, value: 2)
    ///
    public init?<Property>(
        key keyPath: KeyPath<Self, Property>,
        value: Property
    )
        where Property: Equatable
    {
        guard
            let match: Self = .allCases.first(where: { $0[keyPath: keyPath] == value })
        else {
            return nil
        }
        
        self = match
    }
}
