//
//  ResultNoFailureTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 08.06.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct ResultNoFailureTests {
    // MARK: Test Data
    private let resultS: ResultNoFailure<Int> = .success(10)
    private let resultSModified: ResultNoFailure<Int> = .success(11)
    private let resultF: ResultNoFailure<Int> = .failure
    
    // MARK: Tests
    @Test
    func testMap() {
        #expect(resultS.map { $0 + 1 } == resultSModified)
        #expect(resultF.map { $0 + 1 } == resultF)
    }
    
    @Test
    func testFlatMap() {
        #expect(resultS.flatMap { .success($0 + 1) } == resultSModified)
        #expect(resultS.flatMap { _ in .failure } == resultF)
        #expect(resultF.flatMap { .success($0 + 1) } == resultF)
        #expect(resultF.flatMap { _ in .failure } == resultF)
    }
    
    @Test
    func testGet() throws {
        #expect(
            try resultS.get() ==
            10
        )
        
        #expect(throws: (any Error).self) {
            try resultF.get()
        }
    }
    
    @Test
    func testEquality() {
        #expect(resultF == resultF)
        #expect(resultF != resultS)
        #expect(resultS != resultF)
        #expect(resultS == resultS)
        
        #expect(resultS != resultSModified)
    }
}
