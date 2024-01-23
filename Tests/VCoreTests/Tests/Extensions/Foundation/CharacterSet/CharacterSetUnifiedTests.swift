//
//  CharacterSetUnifiedTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.06.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class CharacterSetUnifiedTests: XCTestCase {
    func test() {
        let characterSets: [CharacterSet] = [.init(charactersIn: "A"), .init(charactersIn: "B")]

        let unifiedCharacterSet: CharacterSet = characterSets.unified
        
        XCTAssertEqual(unifiedCharacterSet, CharacterSet(charactersIn: "AB"))
    }
}
