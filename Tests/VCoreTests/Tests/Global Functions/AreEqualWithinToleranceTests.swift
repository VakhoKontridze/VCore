//
//  AreEqualWithinToleranceTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 22.01.25.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct AreEqualWithinToleranceTests {
    @Test
    func test() {
        #expect(areEqual(3.14, 3.1415, tolerance: pow(10, 0))) // 1
        #expect(areEqual(3.14, 3.1415, tolerance: pow(10, -1))) // 0.1
        #expect(areEqual(3.14, 3.1415, tolerance: pow(10, -2))) // 0.01
        #expect(!areEqual(3.14, 3.1415, tolerance: pow(10, -3))) // 0.001
        #expect(!areEqual(3.14, 3.1415, tolerance: 0)) // 0
    }
}
