//
//  RangeInitWithBoundsTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.07.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class RangeInitWithBoundsTests: XCTestCase {
    // MARK: Test Data
    private let inputLower: Int = 1
    private let inputUpper: Int = 10

    // MARK: Tests
    func test() {
        let output: Range<Int> = inputLower..<inputUpper

        let result: Range<Int> = .init(lower: inputLower, upper: inputUpper)

        XCTAssertEqual(result, output)
    }
}

// MARK: - Tests
final class ClosedRangeInitWithBoundsTests: XCTestCase {
    // MARK: Test Data
    private let inputLower: Int = 1
    private let inputUpper: Int = 10

    // MARK: Tests
    func test() {
        let output: ClosedRange<Int> = inputLower...inputUpper

        let result: ClosedRange<Int> = .init(lower: inputLower, upper: inputUpper)

        XCTAssertEqual(result, output)
    }
}
