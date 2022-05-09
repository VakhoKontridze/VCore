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
        guard let date: Date = Calendar.current.date(from: dateComponents) else { fatalError() }
        let outputYear: Int? = dateComponents.year
        let outputMonth: Int? = dateComponents.month
        let outputDay: Int? = dateComponents.day
        
        let resultYear: Int = date.component(.year)
        let resultMonth: Int = date.component(.month)
        let resultDay: Int = date.component(.day)
        
        XCTAssertEqual(resultYear, outputYear)
        XCTAssertEqual(resultMonth, outputMonth)
        XCTAssertEqual(resultDay, outputDay)
    }
    
    func testComponents() {
        let dateComponents: DateComponents = .init(year: 1970, month: 1, day: 1)
        guard let date: Date = Calendar.current.date(from: dateComponents) else { fatalError() }
        let output: DateComponents = dateComponents
        
        let result: DateComponents = date.components([.year, .month, .day])
        
        XCTAssertEqual(result, output)
    }
}
