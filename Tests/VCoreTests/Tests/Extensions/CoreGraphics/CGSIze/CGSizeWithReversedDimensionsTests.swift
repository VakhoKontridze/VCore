//
//  CGSizeWithReversedDimensionsTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 25.02.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct CGSizeWithReversedDimensionsTests {
    @Test
    func test() {
        #expect(
            CGSize(width: 3, height: 4).withReversedDimensions(false) ==
            CGSize(width: 3, height: 4)
        )
        
        #expect(
            CGSize(width: 3, height: 4).withReversedDimensions(true) ==
            CGSize(width: 4, height: 3)
        )
        
        #expect(
            CGSize(width: 3, height: 4).withReversedDimensions() ==
            CGSize(width: 4, height: 3)
        )
    }
}
