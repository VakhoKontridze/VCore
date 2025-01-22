//
//  ResultNoSuccessNoFailureTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 08.06.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct ResultNoSuccessNoFailureTests {
    // MARK: Test Data
    private let resultS: ResultNoSuccessNoFailure = .success
    private let resultF: ResultNoSuccessNoFailure = .failure
    
    // MARK: Tests
    @Test
    func testEquality() {
        #expect(resultF == resultF)
        #expect(resultF != resultS)
        #expect(resultS != resultF)
        #expect(resultS == resultS)
    }
}
