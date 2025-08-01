//
//  ResultNoSuccessTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 08.06.22.
//

import Foundation
import Testing
@testable import VCore

@Suite
struct ResultNoSuccessTests {
    // MARK: Properties
    private let resultS: ResultNoSuccess<TestError> = .success
    private let resultF: ResultNoSuccess<TestError> = .failure(.a)
    private let resultFModified: ResultNoSuccess<TestError> = .failure(.b)
    
    // MARK: Tests
    @Test
    func testMapError() {
        #expect(resultS.mapError { _ in .b } == resultS)
        #expect(resultF.mapError { _ in .b } == resultFModified)
    }
    
    @Test
    func testFlatMapError() {
        #expect(resultS.flatMapError { _ in .success } == resultS)
        #expect(resultS.flatMapError { _ in .failure(.b) } == resultS)
        #expect(resultF.flatMapError { _ in .success } == resultS)
        #expect(resultF.flatMapError { _ in .failure(.b) } == resultFModified)
    }
    
    @Test
    func testEquality() {
        #expect(resultF == resultF)
        #expect(resultF != resultS)
        #expect(resultS != resultF)
        #expect(resultS == resultS)
        
        #expect(resultF != resultFModified)
    }
    
    // MARK: Test Error
    private struct TestError: Error, Equatable {
        // MARK: Properties
        private let code: Int
        
        // MARK: Initializers
        static var a: Self { .init(code: 1) }
        static var b: Self { .init(code: 2) }

        // MARK: Equatable
        static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.code == rhs.code
        }
    }
}
