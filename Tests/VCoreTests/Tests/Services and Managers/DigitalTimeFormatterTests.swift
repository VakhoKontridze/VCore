//
//  DigitalTimeFormatterTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 17.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct DigitalTimeFormatterTests {
    @Test
    func testAllComponents() {
        let formatter: DigitalTimeFormatter = .init()
        
        #expect(formatter.string(from: 0) == "0:00")
        #expect(formatter.string(from: 1) == "0:01")
        #expect(formatter.string(from: 91) == "1:31")
        #expect(formatter.string(from: 536) == "8:56")
        #expect(formatter.string(from: 2336) == "38:56")
        #expect(formatter.string(from: 7248) == "2:00:48")
        #expect(formatter.string(from: 51888) == "14:24:48")
        #expect(formatter.string(from: 95048) == "1:02:24:08")
        #expect(formatter.string(from: 905048) == "10:11:24:08")
        #expect(formatter.string(from: 8553600) == "99:00:00:00")
    }

    @Test
    func testDelimiter() {
        var formatter: DigitalTimeFormatter = .init()
        formatter.delimiter = " "

        #expect(formatter.string(from: 8553600) == "99 00 00 00")
    }

    @Test
    func testHourComponentHasTwoDigits() {
        do {
            var formatter: DigitalTimeFormatter = .init()
            formatter.hourComponentHasTwoDigits = false
            
            #expect(formatter.string(from: 2335.6) == "38:56")
            #expect(formatter.string(from: 7247.6) == "2:00:48")
            #expect(formatter.string(from: 51887.6) == "14:24:48")
        }
        
        do {
            var formatter: DigitalTimeFormatter = .init()
            formatter.hourComponentHasTwoDigits = true
            
            #expect(formatter.string(from: 2335.6) == "38:56")
            #expect(formatter.string(from: 7247.6) == "02:00:48")
            #expect(formatter.string(from: 51887.6) == "14:24:48")
        }
    }
    
    @Test
    func testMinuteComponentHasTwoDigits_False() {
        do {
            var formatter: DigitalTimeFormatter = .init()
            formatter.minuteComponentHasTwoDigits = false
            
            #expect(formatter.string(from: 1) == "0:01")
            #expect(formatter.string(from: 535.6) == "8:56")
            #expect(formatter.string(from: 2335.6) == "38:56")
        }
        
        do {
            var formatter: DigitalTimeFormatter = .init()
            formatter.minuteComponentHasTwoDigits = true
            
            #expect(formatter.string(from: 1) == "00:01")
            #expect(formatter.string(from: 535.6) == "08:56")
            #expect(formatter.string(from: 2335.6) == "38:56")
        }
    }
    
    @Test
    func testSecondComponentHasTwoDigits() {
        do {
            var formatter: DigitalTimeFormatter = .init()
            formatter.secondComponentHasTwoDigits = false
            formatter.minuteComponentIsIncludedIfOnlySecondComponentIsIncluded = false
            
            #expect(formatter.string(from: 0) == "0")
            #expect(formatter.string(from: 1) == "1")
            #expect(formatter.string(from: 91) == "1:31")
        }
        
        do {
            var formatter: DigitalTimeFormatter = .init()
            formatter.secondComponentHasTwoDigits = true
            
            #expect(formatter.string(from: 0) == "0:00")
            #expect(formatter.string(from: 1) == "0:01")
            #expect(formatter.string(from: 91) == "1:31")
        }
    }

    @Test
    func testEmptySignificantComponentsAreIncluded() {
        var formatter: DigitalTimeFormatter = .init()
        formatter.emptySignificantComponentsAreIncluded = true

        #expect(formatter.string(from: 0) == "0:00:00:00")
    }

    @Test
    func testMinuteComponentIsIncludedIfOnlySecondComponentIsIncluded() {
        var formatter: DigitalTimeFormatter = .init()
        formatter.minuteComponentIsIncludedIfOnlySecondComponentIsIncluded = false
        
        #expect(formatter.string(from: 0) == "00")
        #expect(formatter.string(from: 1) == "01")
        #expect(formatter.string(from: 91) == "1:31")
        #expect(formatter.string(from: 2335.6) == "38:56")
    }
}
