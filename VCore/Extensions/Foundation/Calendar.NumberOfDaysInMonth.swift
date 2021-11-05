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
    public func numberOfDaysInMonth(for date: Date) -> Int? {
        range(of: .day, in: .month, for: date)?.count
    }
}
