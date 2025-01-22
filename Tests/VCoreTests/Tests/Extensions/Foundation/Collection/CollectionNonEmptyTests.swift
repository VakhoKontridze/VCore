//
//  CollectionNonEmptyTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 17.11.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct CollectionNonEmptyTests {
    @Test
    func test() {
        #expect(Array<Int>().nonEmpty == nil)
        #expect([1, 2, 3].nonEmpty == [1, 2, 3])
    }
}
