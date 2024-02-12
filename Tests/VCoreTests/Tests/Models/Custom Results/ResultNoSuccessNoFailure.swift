//
//  ResultNoSuccessNoFailure.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 08.06.22.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class ResultNoSuccessNoFailureTests: XCTestCase {
    // MARK: Test Data
    private let resultS: ResultNoSuccessNoFailure = .success
    private let resultF: ResultNoSuccessNoFailure = .failure
    
    // MARK: Tests
    func testEqualOperator() {
        XCTAssertTrue(resultF == resultF)
        XCTAssertFalse(resultF == resultS)
        XCTAssertFalse(resultS == resultF)
        XCTAssertTrue(resultS == resultS)
    }
    
    func testNotEqualOperator() {
        XCTAssertFalse(resultF != resultF)
        XCTAssertTrue(resultF != resultS)
        XCTAssertTrue(resultS != resultF)
        XCTAssertFalse(resultS != resultS)
    }
}
