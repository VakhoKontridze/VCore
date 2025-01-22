//
//  CollectionEnumeratedArrayTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 05.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct CollectionEnumeratedArrayTests {
    @Test
    func test() {
        let characters: [String] = ["A", "B", "C"]
        let enumeratedCharacters: [(offset: Int, element: String)] = characters.enumeratedArray()

        for (i, element) in characters.enumerated() {
            #expect(enumeratedCharacters[i].offset == i)
            #expect(enumeratedCharacters[i].element == element)
        }
    }
}
