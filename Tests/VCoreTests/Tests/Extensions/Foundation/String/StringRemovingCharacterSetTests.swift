//
//  StringRemovingCharacterSetTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class StringRemovingCharacterSetTests: XCTestCase {
    // MARK: Test Data
    private let input: String = "+0123456789"
    private let output: String = "0123456789"
    
    // MARK: Tests
    func testRemoving() {
        XCTAssertEqual(input.removing(.symbols), output)
    }
    
    func testRemove() {
        var result: String = input
        result.remove(.symbols)
        
        XCTAssertEqual(result, output)
    }
}

final class StringRemovingCharacterSetsTests: XCTestCase {
    // MARK: Test Data
    private let input: String = "+0123456789A"
    private let output: String = "0123456789"
    
    // MARK: Tests
    func testRemoving() {
        XCTAssertEqual(input.removing([.symbols, .letters]), output)
    }
    
    func testRemove() {
        var result: String = input
        result.remove([.symbols, .letters])
        
        XCTAssertEqual(result, output)
    }
}
