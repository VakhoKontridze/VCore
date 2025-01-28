//
//  CGSizeInitWithDimensionTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct CGSizeInitWithDimensionTests {
    @Test
    func test() {
        #expect(
            CGSize(dimension: 100) ==
            CGSize(width: 100, height: 100)
        )
    }
}
