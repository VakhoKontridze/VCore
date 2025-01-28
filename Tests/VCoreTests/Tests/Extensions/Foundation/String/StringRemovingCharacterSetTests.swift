//
//  StringRemovingCharacterSetTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct StringRemovingCharacterSetTests {
    @Test
    func testRemovingCharacterSet() {
        #expect(
            "+0123456789".removing(.symbols) ==
            "0123456789"
        )
        
        do {
            var string: String = "+0123456789"
            string.remove(.symbols)

            #expect(string == "0123456789")
        }
    }
    
    @Test
    func testRemovingCharacterSets() {
        #expect(
            "+0123456789A".removing([.symbols, .letters]) ==
            "0123456789"
        )
        
        do {
            var string: String = "+0123456789A"
            string.remove([.symbols, .letters])

            #expect(string == "0123456789")
        }
    }
}
