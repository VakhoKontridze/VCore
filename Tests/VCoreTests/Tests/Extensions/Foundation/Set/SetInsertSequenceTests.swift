//
//  SetInsertSequenceTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 18.12.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct SetInsertSequenceTests {
    @Test
    func test() {
        var set: Set<Int> = [1, 2]
        set.insert(contentsOf: [3, 4])

        #expect(set == [1, 2, 3, 4])
    }
}
