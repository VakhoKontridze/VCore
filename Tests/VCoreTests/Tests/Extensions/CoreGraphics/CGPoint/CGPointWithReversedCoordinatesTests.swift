//
//  CGPointWithReversedCoordinatesTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 02.04.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct CGPointWithReversedCoordinatesTests {
    @Test
    func test() {
        #expect(
            CGPoint(x: 3, y: 4).withReversedCoordinates(false) ==
            CGPoint(x: 3, y: 4)
        )
        
        #expect(
            CGPoint(x: 3, y: 4).withReversedCoordinates(true) ==
            CGPoint(x: 4, y: 3)
        )
        
        #expect(
            CGPoint(x: 3, y: 4).withReversedCoordinates() ==
            CGPoint(x: 4, y: 3)
        )
    }
}
