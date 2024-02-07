//
//  ResultNoSuccessTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 08.06.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class ResultNoSuccessTests: XCTestCase {
    // MARK: Test Data
    private struct TestError: Error, Equatable {
        private let code: Int
        
        static var a: Self { .init(code: 1) }
        static var b: Self { .init(code: 2) }

        static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.code == rhs.code
        }
    }
    
    private let resultS: ResultNoSuccess<TestError> = .success
    private let resultF: ResultNoSuccess<TestError> = .failure(.a)
    private let resultFModified: ResultNoSuccess<TestError> = .failure(.b)
    
    // MARK: Tests
    func testMapError() {
        XCTAssertEqual(resultS.mapError { _ in .b }, resultS)
        XCTAssertEqual(resultF.mapError { _ in .b }, resultFModified)
    }
    
    func testFlatMapError() {
        XCTAssertEqual(resultS.flatMapError { _ in .success }, resultS)
        XCTAssertEqual(resultS.flatMapError { _ in .failure(.b) }, resultS)
        XCTAssertEqual(resultF.flatMapError { _ in .success }, resultS)
        XCTAssertEqual(resultF.flatMapError { _ in .failure(.b) }, resultFModified)
    }
    
    func testEqualOperator() {
        XCTAssertTrue(resultF == resultF)
        XCTAssertFalse(resultF == resultS)
        XCTAssertFalse(resultS == resultF)
        XCTAssertTrue(resultS == resultS)
        
        XCTAssertFalse(resultF == resultFModified)
    }
    
    func testNotEqualOperator() {
        XCTAssertFalse(resultF != resultF)
        XCTAssertTrue(resultF != resultS)
        XCTAssertTrue(resultS != resultF)
        XCTAssertFalse(resultS != resultS)
        
        XCTAssertTrue(resultF != resultFModified)
    }
}
