//
//  HashableEnumeration.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import Foundation

// MARK: - Hashable Enumeration
/// Represents a generic hashable enumeration that can be used to abstract a selection in UI components,
/// independent of indexes.
public protocol HashableEnumeration: Hashable, CaseIterable {}

// MARK: - String Representable Hashable Enumeration
/// Represents a titled generic hashable enumeration that can be used to abstract a selection in UI components,
/// independent of indexes.
public protocol StringRepresentableHashableEnumeration: HashableEnumeration {
    /// `String` representation.
    var stringRepresentation: String { get }
}
