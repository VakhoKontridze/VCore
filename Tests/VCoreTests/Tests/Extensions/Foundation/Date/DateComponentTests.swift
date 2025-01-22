//
//  DateComponentTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct DateComponentTests {
    @Test
    func testComponent() throws {
        let dateComponents: DateComponents = .init(year: 1970, month: 1, day: 1)
        
        let date: Date = try #require(
            Calendar.current.date(from: dateComponents)
        )

        #expect(date.component(.year) == dateComponents.year)
        #expect(date.component(.month) == dateComponents.month)
        #expect(date.component(.day) == dateComponents.day)
    }
    
    @Test
    func testComponents() throws {
        let dateComponents: DateComponents = .init(year: 1970, month: 1, day: 1)
        
        let date: Date = try #require(
            Calendar.current.date(from: dateComponents)
        )

        #expect(
            date.components([.year, .month, .day]) ==
            dateComponents
        )
    }
}
