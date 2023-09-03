//
//  Bool.Toggled.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.09.23.
//

import Foundation

// MARK: - Bool Toggled
extension Bool {
    /// Returns `Boolean` with toggled value.
    ///
    ///     let value: Bool = true.toggled() // false
    ///
    public func toggled() -> Bool {
        !self
    }
}
