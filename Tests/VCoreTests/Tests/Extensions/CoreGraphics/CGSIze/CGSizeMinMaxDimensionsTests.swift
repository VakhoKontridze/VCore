//
//  CGSizeMinMaxDimensionsTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.09.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class CGSizeMinMaxDimensionsTests: XCTestCase {
    // MARK: Test Data
    private let input: CGSize = .init(width: 3, height: 4)

    // MARK: Tests
    func testMin() {
        let output: CGFloat = 3
        let result: CGFloat = input.minDimension()

        XCTAssertEqual(result, output)
    }

    func testMax() {
        let output: CGFloat = 4
        let result: CGFloat = input.maxDimension()

        XCTAssertEqual(result, output)
    }
}
