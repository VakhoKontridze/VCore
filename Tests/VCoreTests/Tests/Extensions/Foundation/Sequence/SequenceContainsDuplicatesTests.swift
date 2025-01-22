//
//  SequenceContainsDuplicatesTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 23.01.24.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct SequenceContainsDuplicatesTests {
    @Test
    func test() {
        #expect(![1, 3, 5].containsDuplicates)
        #expect([1, 1, 3, 5].containsDuplicates)
    }
}
