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
        let chars: [String] = ["A", "B", "C"]
        let result: [(offset: Int, element: String)] = chars.enumeratedArray()
        
        for (i, element) in chars.enumerated() {
            XCTAssertEqual(result[i].offset, i)
            XCTAssertEqual(result[i].element, element)
        }
    }
}
