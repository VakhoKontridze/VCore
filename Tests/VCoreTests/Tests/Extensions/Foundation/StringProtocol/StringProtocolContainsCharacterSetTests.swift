//
//  StringProtocolContainsCharacterSetTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct StringProtocolContainsCharacterSetTests {
    @Test
    func testContainsCharacterSet() {
        #expect("0123456789".contains(.decimalDigits))
        #expect(!"0123456789".contains(.symbols))
    }
    
    @Test
    func testContainsCharacterSetsAny() {
        #expect("+0123456789".contains(any: [.decimalDigits, .letters]))
        #expect("0123456789A".contains(any: [.decimalDigits, .letters]))
        #expect("+0123456789A".contains(any: [.decimalDigits, .letters]))
        #expect(!"0123456789".contains(any: [.symbols, .letters]))
    }
    
    @Test
    func testContainsCharacterSetsAll() {
        #expect(!"+0123456789".contains(all: [.decimalDigits, .letters]))
        #expect("0123456789A".contains(all: [.decimalDigits, .letters]))
        #expect("+0123456789A".contains(all: [.decimalDigits, .letters]))
        #expect(!"0123456789".contains(all: [.symbols, .letters]))
    }
}
