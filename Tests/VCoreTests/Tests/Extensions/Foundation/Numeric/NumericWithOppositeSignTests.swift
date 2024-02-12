//
//  NumericWithOppositeSignTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.02.23.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class NumericWithOppositeSignTests: XCTestCase {
    func testConditionalFalse() {
        let number: Int = 10

        let reversedNumber: Int = number.withOppositeSign(false)

        XCTAssertEqual(reversedNumber, 10)
    }
    
    func testConditionalTrue() {
        let number: Int = 10

        let reversedNumber: Int = number.withOppositeSign(true)

        XCTAssertEqual(reversedNumber, -10)
    }
}
