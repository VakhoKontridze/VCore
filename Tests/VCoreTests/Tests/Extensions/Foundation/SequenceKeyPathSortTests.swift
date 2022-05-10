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
        
        init(_ name: String) { self.name = name }
    }
    
    private let input: [City] = ["London", "Paris", "New York"].map { .init($0) }
    private var output: [City] { input.sorted(by: { $0.name < $1.name }) }
    
    func testSort() {
        var result: [City] = input; result.sort(by: \.name)
        
        XCTAssertEqual(result, output)
    }
    
    func testSorted() {
        XCTAssertEqual(input.sorted(by: \.name), output)
    }
}
