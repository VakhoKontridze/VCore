//
//  SequenceIsUniqueTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class SequenceIsUniqueTests: XCTestCase {
    func test() {
        XCTAssertTrue([1, 3, 5].isUnique)
        XCTAssertFalse([1, 1, 3, 5].isUnique)
    }
}
