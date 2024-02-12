//
//  DateAgeTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.05.22.
//

import Foundation
import OSLog
import XCTest
@testable import VCore

// MARK: - Tests
final class DateAgeTests: XCTestCase {
    func testInvalidDate() {
        guard let birthDate: Date = Calendar.current.date(byAdding: .second, value: 1, to: Date()) else {
            Logger.misc.critical("Failed to generate test data")
            fatalError()
        }

        XCTAssertNil(birthDate.age(inCalendar: .current))
    }

    func testValidDate() {
        guard let birthDate: Date = Calendar.current.date(from: DateComponents(year: 1970, month: 1, day: 1)) else {
            Logger.misc.critical("Failed to generate test data")
            fatalError()
        }

        XCTAssertNotNil(birthDate.age(inCalendar: .current))
    }
}
