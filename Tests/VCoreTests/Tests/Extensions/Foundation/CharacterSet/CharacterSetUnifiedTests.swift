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
        let input: [CharacterSet] = [.decimalDigits, .letters, .symbols]
        let output: CharacterSet = .decimalDigits.union(.letters).union(.symbols)
        
        let result: CharacterSet = input.unified
        
        XCTAssertEqual(result, output)
    }
}
