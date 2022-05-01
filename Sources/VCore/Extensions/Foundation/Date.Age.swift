//
//  Date.Age.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.22.
//

import Foundation

// MARK: - Date Age
extension Date {
    /// Returns age as integer from given date to current time.
    ///
    /// Usage Example:
    ///
    ///     let age: Int? = birthDate.age
    ///
    public var age: Int? {
        Calendar.current.dateComponents([.year], from: self, to: .init()).year
    }
}
