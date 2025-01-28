//
//  LogicalExclusiveOrTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct LogicalExclusiveOrTests {
    @Test
    func test() {
        #expect(!(false ^^ false))
        #expect(false ^^ true)
        #expect(true ^^ false)
        #expect(!(true ^^ true))
    }
}
