//
//  CGSizeMinAndMaxDimensionsTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.09.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct CGSizeMinMaxDimensionsTests {
    @Test
    func testMin() {
        #expect(CGSize(width: 3, height: 4).minDimension() == 3)
    }

    @Test
    func testMax() {
        #expect(CGSize(width: 3, height: 4).maxDimension() == 4)
    }
}
