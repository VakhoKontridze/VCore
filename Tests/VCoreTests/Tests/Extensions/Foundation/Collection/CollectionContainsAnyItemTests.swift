//
//  CollectionContainsAnyItemTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 03.07.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct CollectionContainsAnyItemTests {
    @Test
    func test() {
        #expect([1, 2, 3].containsAnyItem(fromCollection: [3, 4, 5]))
        #expect(![1, 2, 3].containsAnyItem(fromCollection: [4, 5, 6]))
        #expect([1].containsAnyItem(fromCollection: []))
        #expect(![].containsAnyItem(fromCollection: [1]))
    }
}
