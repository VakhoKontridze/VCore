//
//  DigitalTimeFormatterTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 17.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class DigitalTimeFormatterTests: XCTestCase {
    func testAllComponents() {
        let formatter: DigitalTimeFormatter = .init()
        
        XCTAssertEqual(formatter.string(from: 0), "0:00")
        XCTAssertEqual(formatter.string(from: 1), "0:01")
        XCTAssertEqual(formatter.string(from: 91), "1:31")
        XCTAssertEqual(formatter.string(from: 535.6), "8:56")
        XCTAssertEqual(formatter.string(from: 2335.6), "38:56")
        XCTAssertEqual(formatter.string(from: 7247.6), "2:00:48")
        XCTAssertEqual(formatter.string(from: 51887.6), "14:24:48")
        XCTAssertEqual(formatter.string(from: 95047.6), "1:02:24:08")
        XCTAssertEqual(formatter.string(from: 905047.6), "10:11:24:08")
        XCTAssertEqual(formatter.string(from: 8553600), "99:00:00:00")
    }
    
    func testEmptyComponentsShowsAsZeroes() {
        var formatter: DigitalTimeFormatter = .init()
        formatter.emptyComponentsShowAsZeroes = true
        
        XCTAssertEqual(formatter.string(from: 0), "0:00:00:00")
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
            formatter.hourComponentHasTwoDigits = true
            formatter.minuteComponentHasTwoDigits = true
            
            XCTAssertEqual(formatter.string(from: 91), "01:31")
            XCTAssertEqual(formatter.string(from: 2335.6), "38:56")
            XCTAssertEqual(formatter.string(from: 7247.6), "02:00:48")
            XCTAssertEqual(formatter.string(from: 51887.6), "14:24:48")
        }
    }
    
    func testMinuteComponentHasTwoDigits() {
        var formatter: DigitalTimeFormatter = .init()
        formatter.minuteComponentHasTwoDigits = true
        
        XCTAssertEqual(formatter.string(from: 1), "00:01")
        XCTAssertEqual(formatter.string(from: 535.6), "08:56")
        XCTAssertEqual(formatter.string(from: 2335.6), "38:56")
    }
    
    func testSecondComponentHasTwoDigits() {
        do {
            var formatter: DigitalTimeFormatter = .init()
            formatter.secondComponentHasTwoDigits = false
            
            XCTAssertEqual(formatter.string(from: 0), "0:00")
            XCTAssertEqual(formatter.string(from: 1), "0:01")
            XCTAssertEqual(formatter.string(from: 91), "1:31")
        }
        
        do {
            var formatter: DigitalTimeFormatter = .init()
            formatter.secondComponentHasTwoDigits = false
            formatter.minuteComponentShowsIfSecondComponentShows = false
            
            XCTAssertEqual(formatter.string(from: 0), "0")
            XCTAssertEqual(formatter.string(from: 1), "1")
            XCTAssertEqual(formatter.string(from: 91), "1:31")
        }
    }
    
    func testMinuteComponentShowsIfSecondComponentShows() {
        var formatter: DigitalTimeFormatter = .init()
        formatter.minuteComponentShowsIfSecondComponentShows = false
        
        XCTAssertEqual(formatter.string(from: 0), "00") // second has two digits
        XCTAssertEqual(formatter.string(from: 1), "01") // second has two digits
        XCTAssertEqual(formatter.string(from: 91), "1:31")
        XCTAssertEqual(formatter.string(from: 2335.6), "38:56")
    }
    
    func testDelimiter() {
        var formatter: DigitalTimeFormatter = .init()
        formatter.delimiter = " "
        
        XCTAssertEqual(formatter.string(from: 8553600), "99 00 00 00")
    }
}
