//
//  StringProtocolReplacedTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 11.12.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct StringProtocolReplacedTests {
    @Test
    func test() {
        #expect(
            "Lorem ipsum".replaced(at: 0, with: "l") ==
            "lorem ipsum"
        )
        
        do {
            var string: String = "Lorem ipsum"
            string.replace(at: 0, with: "l")

            #expect(string == "lorem ipsum")
        }
    }
}
