//
//  SetTogglingElementTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct SetTogglingElementTests {
    @Test
    func testToggling() {
        let set1: Set<Int> = [1, 3, 5]

        let set2: Set<Int> = set1.toggling(1)
        #expect(set2 == [3, 5])

        let set3: Set<Int> = set2.toggling(1)
        #expect(set3 == [1, 3, 5])
    }
    
    @Test
    func testToggle() {
        var set: Set<Int> = [1, 3, 5]

        set.toggle(1)
        #expect(set == [3, 5])

        set.toggle(1)
        #expect(set == [1, 3, 5])
    }
}
