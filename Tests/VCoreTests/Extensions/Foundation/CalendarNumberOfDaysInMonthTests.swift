//
//  CalendarNumberOfDaysInMonthTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 05.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class CalendarNumberOfDaysInMonthTests: XCTestCase {
    func testNonLeapYearMonths() {
        testHelper(year: 1970, daysInMonths: [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31])
    }
    
    func testLeapYearMonths() {
        testHelper(year: 1972, daysInMonths: [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31])
    }
    
    func testHelper(
        year: Int,
        daysInMonths: [Int]
    ) {
        for i in 1...12 {
            let output: Int = daysInMonths[i-1]
            
            let result: Int? = Calendar
                .current
                .date(from: .init(year: year, month: i))
                .flatMap { Calendar.current.numberOfDaysInMonth(for: $0) }
            
            XCTAssertEqual(result, output)
        }
    }
}
