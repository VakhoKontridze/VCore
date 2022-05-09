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
    private struct Student: Equatable {
        let name: String
        var firstChar: Character { name.first! }
    }
    
    func testGroupingComparison() {
        let input: [String] = ["Kofi", "Abena", "Efua", "Kweku", "Akosua"]
        let output: [[String]] = [["Kofi", "Kweku"], ["Abena", "Akosua"], ["Efua"]]
        
        let result: [[String]] = input.grouped(by: { $0.first == $1.first })

        XCTAssertEqual(result, output)
    }
    
    func testGroupingKeyPath() {
        let input: [Student] = ["Kofi", "Abena", "Efua", "Kweku", "Akosua"].map { .init(name: $0) }
        let output: [[Student]] = [[.init(name: "Kofi"), .init(name: "Kweku")], [.init(name: "Abena"), .init(name: "Akosua")], [.init(name: "Efua")]]

        let result: [[Student]] = input.grouped(by: \.firstChar)
        
        XCTAssertEqual(result, output)
    }
}
