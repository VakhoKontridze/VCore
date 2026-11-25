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
nonisolated struct ResultNoSuccessTests {
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
    
    // MARK: Types
    nonisolated private struct TestError: BaseErrorProtocol {
        // MARK: Properties
        static let domain: String = "com.vakhtang-kontridze.vcore.tests.result-no-success"
        let code: Int
        let description: String
        
        // MARK: Initializers
        static var a: Self { .init(code: 1, description: "A") }
        static var b: Self { .init(code: 2, description: "B") }
    }
}
