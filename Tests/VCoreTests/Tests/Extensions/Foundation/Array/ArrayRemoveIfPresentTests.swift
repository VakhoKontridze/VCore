//
//  ArrayRemoveIfPresentTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 26.11.23.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class ArrayRemoveIfPresentTests: XCTestCase {
    func testElement() {
        let array: [Int] = [1, 2, 3]

        var filteredArray = array
        filteredArray.removeIfPresent(3)

        XCTAssertEqual(filteredArray, [1, 2])
    }

    func testElements() {
        let array: [Int] = [1, 2, 3]

        var filteredArray = array
        filteredArray.removeIfPresent(contentsOf: [2, 3])

        XCTAssertEqual(filteredArray, [1])
    }
}
