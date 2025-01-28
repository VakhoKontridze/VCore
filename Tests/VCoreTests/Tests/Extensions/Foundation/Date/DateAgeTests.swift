//
//  DateAgeTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct DateAgeTests {
    @Test
    func testInvalidDate() throws {
        let birthDate: Date = try #require(
            Calendar.current.date(byAdding: .second, value: 1, to: Date())
        )

        #expect(birthDate.age(inCalendar: .current) == nil)
    }

    @Test
    func testValidDate() throws {
        let birthDate: Date = try #require(
            Calendar.current.date(from: DateComponents(year: 1970, month: 1, day: 1))
        )

        #expect(birthDate.age(inCalendar: .current) != nil)
    }
}
