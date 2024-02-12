//
//  BinaryDataUnitTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 15.07.22.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class BinaryDataUnitTests: XCTestCase {
    func testConversion() {
        XCTAssertEqual(BinaryDataUnit.convert(5, .GiB, to: .MiB), 5120)
        XCTAssertEqual(BinaryDataUnit.convert(5120, .MiB, to: .GiB), 5)
    }
    
    func testConversionToAnotherType() {
        XCTAssertEqual(BinaryDataUnit.convert(5, .GiB, to: DecimalDataUnit.MB), 5368.70912, accuracy: pow(10, -6))
        XCTAssertEqual(BinaryDataUnit.convert(5000, .MiB, to: DecimalDataUnit.GB), 5.24288, accuracy: pow(10, -6))
    }
    
    func testDoubleExtension() {
        XCTAssertEqual(5_000_000.binaryBytesConverted(to: .MiB), 4.76837, accuracy: pow(10, -5))
    }
}
