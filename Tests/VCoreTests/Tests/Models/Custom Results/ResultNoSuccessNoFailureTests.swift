//
//  ResultNoSuccessNoFailureTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 08.06.22.
//

import Foundation
import Testing
@testable import VCore

@Suite
struct ResultNoSuccessNoFailureTests {
    // MARK: Properties
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
