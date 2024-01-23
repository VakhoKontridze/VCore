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
    func testMin() {
        let size: CGSize = .init(width: 3, height: 4)

        let dimension: CGFloat = size.minDimension()

        XCTAssertEqual(dimension, 3)
    }

    func testMax() {
        let size: CGSize = .init(width: 3, height: 4)

        let dimension: CGFloat = size.maxDimension()

        XCTAssertEqual(dimension, 4)
    }
}
