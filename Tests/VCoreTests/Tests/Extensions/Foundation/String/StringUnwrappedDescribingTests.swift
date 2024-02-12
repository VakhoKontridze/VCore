//
//  StringUnwrappedDescribingTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class StringUnwrappedDescribingTests: XCTestCase {
    func testValue() {
        let number: Int? = 5

        let string: String? = .init(unwrappedDescribing: number)

        XCTAssertEqual(string, "5")
    }
    
    func testNil() {
        let number: Int? = nil

        let string: String? = .init(unwrappedDescribing: number)

        XCTAssertNil(string)
    }
}
