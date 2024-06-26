//
//  DigitalTimeFormatterTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 17.05.22.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class DigitalTimeFormatterTests: XCTestCase {
    func testAllComponents() {
        let formatter: DigitalTimeFormatter = .init()
        
        XCTAssertEqual(formatter.string(from: 0), "0:00")
        XCTAssertEqual(formatter.string(from: 1), "0:01")
        XCTAssertEqual(formatter.string(from: 91), "1:31")
        XCTAssertEqual(formatter.string(from: 536), "8:56")
        XCTAssertEqual(formatter.string(from: 2336), "38:56")
        XCTAssertEqual(formatter.string(from: 7248), "2:00:48")
        XCTAssertEqual(formatter.string(from: 51888), "14:24:48")
        XCTAssertEqual(formatter.string(from: 95048), "1:02:24:08")
        XCTAssertEqual(formatter.string(from: 905048), "10:11:24:08")
        XCTAssertEqual(formatter.string(from: 8553600), "99:00:00:00")
    }

    func testDelimiter() {
        var formatter: DigitalTimeFormatter = .init()
        formatter.delimiter = " "

        XCTAssertEqual(formatter.string(from: 8553600), "99 00 00 00")
    }

    func testHourComponentHasTwoDigits() {
        do {
            var formatter: DigitalTimeFormatter = .init()
            formatter.hourComponentHasTwoDigits = true
            
            XCTAssertEqual(formatter.string(from: 2335.6), "38:56")
            XCTAssertEqual(formatter.string(from: 7247.6), "02:00:48")
            XCTAssertEqual(formatter.string(from: 51887.6), "14:24:48")
        }
        
        do {
            var formatter: DigitalTimeFormatter = .init()
            formatter.hourComponentHasTwoDigits = false

            XCTAssertEqual(formatter.string(from: 2335.6), "38:56")
            XCTAssertEqual(formatter.string(from: 7247.6), "2:00:48")
            XCTAssertEqual(formatter.string(from: 51887.6), "14:24:48")
        }
    }
    
    func testMinuteComponentHasTwoDigits() {
        do {
            var formatter: DigitalTimeFormatter = .init()
            formatter.minuteComponentHasTwoDigits = false

            XCTAssertEqual(formatter.string(from: 1), "0:01")
            XCTAssertEqual(formatter.string(from: 535.6), "8:56")
            XCTAssertEqual(formatter.string(from: 2335.6), "38:56")
        }

        do {
            var formatter: DigitalTimeFormatter = .init()
            formatter.minuteComponentHasTwoDigits = true

            XCTAssertEqual(formatter.string(from: 1), "00:01")
            XCTAssertEqual(formatter.string(from: 535.6), "08:56")
            XCTAssertEqual(formatter.string(from: 2335.6), "38:56")
        }
    }
    
    func testSecondComponentHasTwoDigits() {
        do {
            var formatter: DigitalTimeFormatter = .init()
            formatter.secondComponentHasTwoDigits = true

            XCTAssertEqual(formatter.string(from: 0), "0:00")
            XCTAssertEqual(formatter.string(from: 1), "0:01")
            XCTAssertEqual(formatter.string(from: 91), "1:31")
        }
        
        do {
            var formatter: DigitalTimeFormatter = .init()
            formatter.secondComponentHasTwoDigits = false
            formatter.minuteComponentIsIncludedIfOnlySecondComponentIsIncluded = false
            
            XCTAssertEqual(formatter.string(from: 0), "0")
            XCTAssertEqual(formatter.string(from: 1), "1")
            XCTAssertEqual(formatter.string(from: 91), "1:31")
        }
    }

    func testEmptySignificantComponentsAreIncluded() {
        var formatter: DigitalTimeFormatter = .init()
        formatter.emptySignificantComponentsAreIncluded = true

        XCTAssertEqual(formatter.string(from: 0), "0:00:00:00")
    }

    func testMinuteComponentIsIncludedIfOnlySecondComponentIsIncluded() {
        var formatter: DigitalTimeFormatter = .init()
        formatter.minuteComponentIsIncludedIfOnlySecondComponentIsIncluded = false
        
        XCTAssertEqual(formatter.string(from: 0), "00")
        XCTAssertEqual(formatter.string(from: 1), "01")
        XCTAssertEqual(formatter.string(from: 91), "1:31")
        XCTAssertEqual(formatter.string(from: 2335.6), "38:56")
    }
}
