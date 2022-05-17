//
//  VCoreErrorTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class VCoreErrorTests: XCTestCase {
    // MARK: Test Data
    private struct SomeError: VCoreError {
        var domain: String
        var code: Int
        var description: String
    }
    
    // MARK: Tests
    func test() {
        XCTAssertEqual(SomeError.errorDomain, "com.vcore")
    }
}
