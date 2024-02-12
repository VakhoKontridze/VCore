//
//  CollectionEnumeratedArrayTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 05.05.22.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class CollectionEnumeratedArrayTests: XCTestCase {
    func test() {
        let characters: [String] = ["A", "B", "C"]
        let enumeratedCharacters: [(offset: Int, element: String)] = characters.enumeratedArray()

        for (i, element) in characters.enumerated() {
            XCTAssertEqual(enumeratedCharacters[i].offset, i)
            XCTAssertEqual(enumeratedCharacters[i].element, element)
        }
    }
}
