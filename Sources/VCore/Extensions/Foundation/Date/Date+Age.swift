//
//  Date+Age.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.22.
//

import Foundation

// MARK: - Date + Age
extension Date {
    /// Returns age as integer from given date to current time.
    ///
    ///     let age: Int? = birthDate.age()
    ///
    public func age(
        inCalendar calendar: Calendar = .current
    ) -> Int? {
        let now: Date = .init()

        guard now >= self else { return nil }

        return calendar.dateComponents([.year], from: self, to: now).year
    }
}
