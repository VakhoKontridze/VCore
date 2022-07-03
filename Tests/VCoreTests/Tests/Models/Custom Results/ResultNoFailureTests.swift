//
//  ResultNoFailureTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 08.06.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class ResultNoFailureTests: XCTestCase {
    // MARK: Test Data
    private let resultS: ResultNoFailure<Int> = .success(10)
    private let resultSModified: ResultNoFailure<Int> = .success(11)
    private let resultF: ResultNoFailure<Int> = .failure
    
    // MARK: Tests
    func testMap() {
        XCTAssertEqual(resultS.map { $0 + 1 }, resultSModified)
        XCTAssertEqual(resultF.map { $0 + 1 }, resultF)
    }
    
    func testFlatMap() {
        XCTAssertEqual(resultS.flatMap { .success($0 + 1) }, resultSModified)
        XCTAssertEqual(resultS.flatMap { _ in .failure }, resultF)
        XCTAssertEqual(resultF.flatMap { .success($0 + 1) }, resultF)
        XCTAssertEqual(resultF.flatMap { _ in .failure }, resultF)
    }
    
    func testGet() {
        XCTAssertEqual(try resultS.get(), 10)
        XCTAssertThrowsError(try resultF.get())
    }
    
    func testEqualOperator() {
        XCTAssertTrue(resultF == resultF)
        XCTAssertFalse(resultF == resultS)
        XCTAssertFalse(resultS == resultF)
        XCTAssertTrue(resultS == resultS)
        
        XCTAssertFalse(resultS == resultSModified)
    }
    
    func testNotEqualOperator() {
        XCTAssertFalse(resultF != resultF)
        XCTAssertTrue(resultF != resultS)
        XCTAssertTrue(resultS != resultF)
        XCTAssertFalse(resultS != resultS)
        
        XCTAssertTrue(resultS != resultSModified)
    }
}
