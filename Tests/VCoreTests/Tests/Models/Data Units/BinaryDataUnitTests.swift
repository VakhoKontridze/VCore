//
//  BinaryDataUnitTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 15.07.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct BinaryDataUnitTests {
    @Test
    func testConversion() {
        #expect(
            BinaryDataUnit.convert(5, .GiB, to: .MiB) ==
            5120
        )
        
        #expect(
            BinaryDataUnit.convert(5120, .MiB, to: .GiB) ==
            5
        )
    }
    
    @Test
    func testConversionToAnotherType() {
        #expect(
            areEqual(
                BinaryDataUnit.convert(5, .GiB, to: DecimalDataUnit.MB),
                5368.70912,
                tolerance: pow(10, -5)
            )
        )
        
        #expect(
            areEqual(
                BinaryDataUnit.convert(5000, .MiB, to: DecimalDataUnit.GB),
                5.24288,
                tolerance: pow(10, -5)
            )
        )
    }
    
    @Test
    func testDoubleExtension() {
        #expect(
            areEqual(
                5_000_000.binaryBytesConverted(to: .MiB),
                4.76837,
                tolerance: pow(10, -5)
            )
        )
    }
}
