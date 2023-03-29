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
        testHelper(
            year: 1970,
            numberOfDaysInMonths: [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        )
    }
    
    func testLeapYearMonths() {
        testHelper(
            year: 1972,
            numberOfDaysInMonths: [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        )
    }
    
    func testHelper(
        year: Int,
        numberOfDaysInMonths: [Int]
    ) {
        for i in 1...12 {
            let numberOfDaysInMonth1: Int? = Calendar
                .current
                .date(from: DateComponents(year: year, month: i))
                .flatMap { Calendar.current.numberOfDaysInMonth(date: $0) }
            
            let numberOfDaysInMonth2: Int? = Calendar
                .current
                .numberOfDaysInMonth(year: year, month: i)
            
            XCTAssertEqual(numberOfDaysInMonth1, numberOfDaysInMonths[i-1])
            XCTAssertEqual(numberOfDaysInMonth2, numberOfDaysInMonths[i-1])
        }
    }
}
