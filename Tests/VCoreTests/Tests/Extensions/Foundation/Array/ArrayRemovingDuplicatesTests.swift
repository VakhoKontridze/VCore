//
//  ArrayRemovingDuplicatesTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class ArrayRemovingDuplicatesTests: XCTestCase {
    func testRemoving() {
        let array: [Int] = [1, 1, 3, 5, 5]

        let filteredArray: [Int] = array.removingDuplicates()

        XCTAssertEqual(filteredArray, [1, 3, 5])
    }
    
    func testRemove() {
        let array: [Int] = [1, 1, 3, 5, 5]

        var filteredArray: [Int] = array
        filteredArray.removeDuplicates()

        XCTAssertEqual(filteredArray, [1, 3, 5])
    }
}
