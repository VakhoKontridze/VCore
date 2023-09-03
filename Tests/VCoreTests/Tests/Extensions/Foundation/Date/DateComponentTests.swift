//
//  DateComponentTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class DateComponentTests: XCTestCase {
    func testComponent() {
        let dateComponents: DateComponents = .init(year: 1970, month: 1, day: 1)
        guard let date: Date = Calendar.current.date(from: dateComponents) else { XCTFail(); return }
        
        XCTAssertEqual(date.component(.year), dateComponents.year)
        XCTAssertEqual(date.component(.month), dateComponents.month)
        XCTAssertEqual(date.component(.day), dateComponents.day)
    }
    
    func testComponents() {
        let dateComponents: DateComponents = .init(year: 1970, month: 1, day: 1)
        guard let date: Date = Calendar.current.date(from: dateComponents) else { XCTFail(); return }
        
        XCTAssertEqual(
            date.components([.year, .month, .day]),
            dateComponents
        )
    }
}
