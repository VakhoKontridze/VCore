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
    func test() {
        let calendar: Calendar = .current
        
        guard let birthDate: Date = calendar.date(from: .init(year: 1970, month: 1, day: 1)) else { fatalError() }
        
        XCTAssertNotNil(birthDate.age(inCalendar: calendar))
    }
}
