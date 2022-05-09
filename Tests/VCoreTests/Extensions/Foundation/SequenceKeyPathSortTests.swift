//
//  SequenceKeyPathSortTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class SequenceKeyPathSortTests: XCTestCase {
    private struct City: Equatable {
        let name: String
    }
    
    private let input: [City] = ["London", "Paris", "New York"].map { .init(name: $0) }
    private var output: [City] { input.sorted(by: { $0.name < $1.name }) }
    
    func testSort() {
        var result: [City] = input; result.sort(by: \.name)
        
        XCTAssertEqual(result, output)
    }
    
    func testSorted() {
        let result: [City] = input.sorted(by: \.name)
        
        XCTAssertEqual(result, output)
    }
}
