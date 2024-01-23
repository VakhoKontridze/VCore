//
//  SetTogglingElementTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class SetTogglingElementTests: XCTestCase {
    func testToggling() {
        let set1: Set<Int> = [1, 3, 5]

        let set2: Set<Int> = set1.toggling(1)
        XCTAssertEqual(set2, [3, 5])

        let set3: Set<Int> = set2.toggling(1)
        XCTAssertEqual(set3, [1, 3, 5])
    }
    
    func testToggle() {
        var set: Set<Int> = [1, 3, 5]

        set.toggle(1)
        XCTAssertEqual(set, [3, 5])

        set.toggle(1)
        XCTAssertEqual(set, [1, 3, 5])
    }
}
