//
//  SequenceConditionalGroupingTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct SequenceConditionalGroupingTests {
    @Test
    func testPredicate() {
        #expect(
            ["Kofi", "Abena", "Efua", "Kweku", "Akosua"].grouped(by: { $0.first == $1.first }) ==
            [["Kofi", "Kweku"], ["Abena", "Akosua"], ["Efua"]]
        )
    }
    
    @Test
    func testKeyPath() {
        #expect(
            ["Kofi", "Abena", "Efua", "Kweku", "Akosua"].grouped(by: \.first) ==
            [["Kofi", "Kweku"], ["Abena", "Akosua"], ["Efua"]]
        )
    }
}
