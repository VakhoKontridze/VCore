//
//  Bool+Toggled.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.09.23.
//

import Foundation

// MARK: - Bool + Toggled
extension Bool {
    /// Returns `Bool` with a toggled value.
    ///
    ///     let value: Bool = true.toggled() // false
    ///
    /// Can be useful when dealing with `Optional` values.
    ///
    ///     let value: Bool? = ...
    ///
    ///     let value1: Bool? = value.map { !$0 }
    ///     let value2: Bool? = value?.toggled()
    ///
    public func toggled() -> Bool {
        !self
    }
}
