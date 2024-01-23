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
    func testPredicate() {
        let array: [String] = ["Kofi", "Abena", "Efua", "Kweku", "Akosua"]
        
        let groupedArray: [[String]] = array.grouped(by: { $0.first == $1.first })
        
        XCTAssertEqual(
            groupedArray,
            [["Kofi", "Kweku"], ["Abena", "Akosua"], ["Efua"]]
        )
    }
    
    func testKeyPath() {
        let array: [String] = ["Kofi", "Abena", "Efua", "Kweku", "Akosua"]

        let groupedArray: [[String]] = array.grouped(by: \.first)

        XCTAssertEqual(
            groupedArray,
            [["Kofi", "Kweku"], ["Abena", "Akosua"], ["Efua"]]
        )
    }
}
