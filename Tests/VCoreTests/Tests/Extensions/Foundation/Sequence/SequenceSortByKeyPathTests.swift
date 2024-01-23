//
//  SequenceSortByKeyPathTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class SequenceSortByKeyPathTests: XCTestCase {
    // MARK: Test Data
    private struct City: Equatable {
        let name: String
        
        init(_ name: String) { self.name = name }
    }
    
    // MARK: Tests
    func testSort() {
        let array: [City] = [.init("London"), .init("Paris"), .init("New York")]

        var sortedArray: [City] = array
        sortedArray.sort(by: \.name)

        XCTAssertEqual(sortedArray, [City("London"), City("New York"), City("Paris")])
    }
    
    func testSorted() {
        let array: [City] = [.init("London"), .init("Paris"), .init("New York")]

        let sortedArray: [City] = array.sorted(by: \.name)

        XCTAssertEqual(sortedArray, [City("London"), City("New York"), City("Paris")])
    }
}
