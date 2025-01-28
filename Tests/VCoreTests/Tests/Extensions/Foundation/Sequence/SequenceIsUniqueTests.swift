//
//  SequenceIsUniqueTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct SequenceIsUniqueTests {
    @Test
    func test() {
        #expect([1, 3, 5].isUnique)
        #expect(![1, 1, 3, 5].isUnique)
    }
}
