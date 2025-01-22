//
//  CharacterSetUnifiedTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.06.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct CharacterSetUnifiedTests {
    @Test
    func test() {
        #expect(
            [CharacterSet(charactersIn: "A"), CharacterSet(charactersIn: "B")].unified ==
            CharacterSet(charactersIn: "AB")
        )
    }
}
