//
//  Calendar+NumberOfDaysInMonth.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/5/21.
//

import Foundation

// MARK: - Calendar + Number of Days in Month
extension Calendar {
    /// Returns number of days in a month for the given date.
    ///
    ///     let date: Date = .init()
    ///
    ///     let numberOfDaysInMonth: Int? = Calendar.current.numberOfDaysInMonth(date: date)) // 31
    ///
    public func numberOfDaysInMonth(date: Date) -> Int? {
        range(of: .day, in: .month, for: date)?.count
    }
    
    /// Returns number of days in a month for the given date.
    ///
    ///     let year: Int = 1970
    ///     let month: Int = 1
    ///
    ///     let numberOfDaysInMonth: Int? = Calendar.current.numberOfDaysInMonth(year: year, month: month)) // 31
    ///
    public func numberOfDaysInMonth(year: Int, month: Int) -> Int? {
        var components: DateComponents = .init()
        components.year = year
        components.month = month

        guard let date: Date = self.date(from: components) else { return nil }

        return numberOfDaysInMonth(date: date)
    }
}
