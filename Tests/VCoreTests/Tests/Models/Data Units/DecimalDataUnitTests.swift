//
//  DecimalDataUnitTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 15.07.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class DecimalDataUnitTests: XCTestCase {
    func testConversion() {
        XCTAssertEqual(DecimalDataUnit.convert(5, .GB, to: .MB), 5000)
        XCTAssertEqual(DecimalDataUnit.convert(5000, .MB, to: .GB), 5)
    }
    
    func testConversionToAnotherType() {
        XCTAssertEqual(DecimalDataUnit.convert(5, .GB, to: BinaryDataUnit.MiB), 4768.37158, accuracy: pow(10, -5))
        XCTAssertEqual(DecimalDataUnit.convert(5000, .MB, to: BinaryDataUnit.GiB), 4.65661, accuracy: pow(10, -5))
    }
    
    func testDoubleExtension() {
        XCTAssertEqual(5_000_000.decimalBytesConverted(to: .MB), 5)
    }
}
