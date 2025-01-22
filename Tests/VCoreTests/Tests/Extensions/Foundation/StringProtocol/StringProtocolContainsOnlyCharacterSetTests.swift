//
//  StringProtocolContainsOnlyCharacterSetTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct StringContainsOnlyCharacterSetTests {
    @Test
    func testContainsOnlyCharacterSet() {
        #expect("0123456789".contains(only: .decimalDigits))
        #expect(!"+0123456789".contains(only: .decimalDigits))
    }
    
    @Test
    func testContainsOnlyCharacterSets() {
        #expect("0123456789A".contains(only: [.decimalDigits, .letters]))
        #expect(!"+0123456789A".contains(only: [.decimalDigits, .letters]))
    }
}
