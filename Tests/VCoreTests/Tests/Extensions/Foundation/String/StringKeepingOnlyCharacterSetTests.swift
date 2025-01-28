//
//  StringKeepingOnlyCharacterSetTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct StringKeepingCharacterSetTests {
    @Test
    func testKeepingCharacterSet() {
        #expect(
            "+0123456789".keeping(only: .decimalDigits) ==
            "0123456789"
        )

        do {
            var string: String = "+0123456789"
            string.keep(only: .decimalDigits)

            #expect(string == "0123456789")
        }
    }
    
    @Test
    func testKeepingCharacterSets() {
        #expect(
            "+0123456789A".keeping(only: [.decimalDigits, .symbols]) ==
            "+0123456789"
        )
        
        do {
            var string: String = "+0123456789A"
            string.keep(only: [.decimalDigits, .symbols])

            #expect(string == "+0123456789")
        }
    }
}
