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
    
    private let input: [City] = ["London", "Paris", "New York"].map { City($0) }
    private var output: [City] { input.sorted(by: { $0.name < $1.name }) }
    
    // MARK: Tests
    func testSort() {
        var result: [City] = input
        result.sort(by: \.name)
        
        XCTAssertEqual(result, output)
    }
    
    func testSorted() {
        XCTAssertEqual(input.sorted(by: \.name), output)
    }
}
