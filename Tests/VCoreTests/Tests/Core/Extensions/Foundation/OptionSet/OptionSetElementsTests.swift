//
//  OptionSetElementsTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 20.05.22.
//

import Foundation
import Testing
@testable import VCore

@Suite
nonisolated struct OptionSetElementsTests {
    // MARK: Tests
    @Test
    func test() {
        #expect(Gender.male.elements == [.male])
        #expect(Gender.female.elements == [.female])
        #expect(Gender.all.elements == [.male, .female])
    }
    
    // MARK: Types
    private nonisolated struct Gender: OptionSet {
        static let male: Self = .init(rawValue: 1 << 0)
        static let female: Self = .init(rawValue: 1 << 1)

        static var all: Self { [.male, .female] }

        let rawValue: Int
    }
}
