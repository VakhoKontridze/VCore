//
//  AutoPrecisionNumberFormatter.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 17.05.22.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class AutoPrecisionNumberFormatterTests: XCTestCase {
    func testValidFormatting() {
        let formatter: AutoPrecisionNumberFormatter = .init(
            minFractions: 0,
            maxFractions: 2
        )
        
        XCTAssertEqual(formatter.string(from: 3), "3")
        XCTAssertEqual(formatter.string(from: 3.0), "3")
        XCTAssertEqual(formatter.string(from: 3.1), "3.1")
        XCTAssertEqual(formatter.string(from: 3.10), "3.1")
        XCTAssertEqual(formatter.string(from: 3.14), "3.14")
        XCTAssertEqual(formatter.string(from: 3.140), "3.14")
        XCTAssertEqual(formatter.string(from: 3.141), "3.14")
        XCTAssertEqual(formatter.string(from: 3.1410), "3.14")
    }
    
    func testExtension() {
        XCTAssertEqual(3.1415.rounded(maxFractions: 2), "3.14")
    }
}
