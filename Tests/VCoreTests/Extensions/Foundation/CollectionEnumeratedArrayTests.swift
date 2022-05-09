//
//  CollectionEnumeratedArrayTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 05.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class CollectionEnumeratedArrayTests: XCTestCase {
    func test() {
        let input: [String] = ["A", "B", "C"]
        
        let result: [(offset: Int, element: String)] = input.enumeratedArray()
        
        for (i, element) in input.enumerated() {
            let outputOffset: Int = i
            let outputElement: String = element
            
            XCTAssertEqual(result[i].offset, outputOffset)
            XCTAssertEqual(result[i].element, outputElement)
        }
    }
}
