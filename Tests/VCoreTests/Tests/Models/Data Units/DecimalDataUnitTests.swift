//
//  DecimalDataUnitTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 15.07.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct DecimalDataUnitTests {
    @Test
    func testConversion() {
        #expect(
            DecimalDataUnit.convert(5, .GB, to: .MB) ==
            5000
        )
        
        #expect(
            DecimalDataUnit.convert(5000, .MB, to: .GB) ==
            5
        )
    }
    
    @Test
    func testConversionToAnotherType() {
        #expect(
            areEqual(
                DecimalDataUnit.convert(5, .GB, to: BinaryDataUnit.MiB),
                4768.37158,
                tolerance: pow(10, -5)
            )
        )
        
        #expect(
            areEqual(
                DecimalDataUnit.convert(5000, .MB, to: BinaryDataUnit.GiB),
                4.65661,
                tolerance: pow(10, -5)
            )
        )
    }
    
    @Test
    func testDoubleExtension() {
        #expect(
            5_000_000.decimalBytesConverted(to: .MB) ==
            5
        )
    }
}
