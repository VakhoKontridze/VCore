//
//  AutoPrecisionNumberFormatterTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 17.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct AutoPrecisionNumberFormatterTests {
    @Test
    func testValidFormatting() {
        let formatter: AutoPrecisionNumberFormatter = .init(
            minFractions: 0,
            maxFractions: 2
        )
        
        #expect(formatter.string(from: 3) == "3")
        #expect(formatter.string(from: 3.1) == "3.1")
        #expect(formatter.string(from: 3.14) == "3.14")
        #expect(formatter.string(from: 3.141) == "3.14")
    }
    
    @Test
    func testExtension() {
        let value: String? = 3.1415.rounded(
            minFractions: 0,
            maxFractions: 2
        )
        
        #expect(value == "3.14")
    }
}
