//
//  SequenceCountTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 22.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class SequenceCountTests: XCTestCase {
    func test() {
        let numbers: [Int] = [3, 7, 4, -2, 9, -6, 10, 1]
        
        XCTAssertEqual(numbers.count { $0 > 0 }, 6)
    }
}
