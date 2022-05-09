//
//  SetToggleTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class SetToggleTests: XCTestCase {
    func test() {
        let num: Int = 1
        let input: Set<Int> = [1, 3, 5]
        let output: Set<Int> = input
        let outputRemoved: Set<Int> = input.subtracting([num])
        
        var result: Set<Int> = input
        
        result.toggle(num)
        XCTAssertEqual(result, outputRemoved)
        
        result.toggle(num)
        XCTAssertEqual(result, output)
    }
}
