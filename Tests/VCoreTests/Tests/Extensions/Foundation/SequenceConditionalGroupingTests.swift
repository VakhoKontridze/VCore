//
//  SequenceConditionalGroupingTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class SequenceConditionalGroupingTests: XCTestCase {
    // MARK: Test Data
    private struct Student: Equatable {
        let name: String
        var firstChar: Character { name.first! } // Force-unwrap
        
        init(_ name: String) { self.name = name }
    }
    
    // MARK: Tests
    func testGroupingComparison() {
        let input: [String] = ["Kofi", "Abena", "Efua", "Kweku", "Akosua"]
        let output: [[String]] = [["Kofi", "Kweku"], ["Abena", "Akosua"], ["Efua"]]
        
        let result: [[String]] = input.grouped(by: { $0.first == $1.first })

        XCTAssertEqual(result, output)
    }
    
    func testGroupingKeyPath() {
        let input: [Student] = ["Kofi", "Abena", "Efua", "Kweku", "Akosua"].map { Student($0) }
        let output: [[Student]] = [[.init("Kofi"), .init("Kweku")], [.init("Abena"), .init("Akosua")], [.init("Efua")]]

        let result: [[Student]] = input.grouped(by: \.firstChar)
        
        XCTAssertEqual(result, output)
    }
}
