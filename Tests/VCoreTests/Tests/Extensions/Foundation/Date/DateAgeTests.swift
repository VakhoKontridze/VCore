//
//  DateAgeTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class DateAgeTests: XCTestCase {
    func testInvalidDate() {
        let calendar: Calendar = .current

        guard let birthDate: Date = Calendar.current.date(byAdding: .second, value: 1, to: Date()) else { XCTFail(); return }

        XCTAssertNil(birthDate.age(inCalendar: calendar))
    }

    func testValidDate() {
        let calendar: Calendar = .current
        
        guard let birthDate: Date = calendar.date(from: DateComponents(year: 1970, month: 1, day: 1)) else { XCTFail(); return }
        
        XCTAssertNotNil(birthDate.age(inCalendar: calendar))
    }
}
