//
//  JSONEncoderErrorTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 15.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class JSONEncoderErrorTests: XCTestCase {
    func testErrorCodes() {
        let codes: [Int] = JSONEncoderError.allCases.map { $0.code }
        
        XCTAssertTrue(codes.isUnique)
    }
}
