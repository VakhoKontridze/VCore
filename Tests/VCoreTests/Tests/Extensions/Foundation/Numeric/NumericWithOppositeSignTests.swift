//
//  NumericWithOppositeSignTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 25.02.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct NumericWithOppositeSignTests {
    @Test
    func test() {
        #expect(10.withOppositeSign(false) == 10)
        #expect(10.withOppositeSign(true) == -10)
        #expect(10.withOppositeSign() == -10)
    }
}
