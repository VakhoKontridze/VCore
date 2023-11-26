//
//  ArrayRemoveIfPresentTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 26.11.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class ArrayRemoveIfPresentTests: XCTestCase {
    func testElement() {
        let input: [Int] = [1, 2, 3]
        let output: [Int] = [1, 2]

        var resut = input
        resut.removeIfPresent(3)

        XCTAssertEqual(resut, output)
    }

    func testElements() {
        let input: [Int] = [1, 2, 3]
        let output: [Int] = [1]

        var resut = input
        resut.removeIfPresent(contentsOf: [2, 3])

        XCTAssertEqual(resut, output)
    }
}
