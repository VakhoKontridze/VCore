//
//  Calendar.NumberOfDaysInMonth.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/5/21.
//

import Foundation

// MARK: - Number of Days in Month
extension Calendar {
    /// Returns number of days in a month for the given date.
    ///
    /// Usage Example:
    ///
    ///     let date: Date = .init()
    ///     let numberOfDaysInMonth: Int? = Calendar.current.numberOfDaysInMonth(for: date)) // 31
    ///
    public func numberOfDaysInMonth(for date: Date) -> Int? {
        range(of: .day, in: .month, for: date)?.count
    }
}
