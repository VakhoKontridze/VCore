//
//  SetInsertSequenceTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 18.12.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class SetInsertSequenceTests: XCTestCase {
    func test() {
        let input: Set<Int> = [1, 2]
        let output: Set<Int> = [1, 2, 3, 4]

        var result: Set<Int> = input
        result.insert(contentsOf: [3, 4])

        XCTAssertEqual(result, output)
    }
}
