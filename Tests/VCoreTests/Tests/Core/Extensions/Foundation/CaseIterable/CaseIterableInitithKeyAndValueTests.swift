//
//  CaseIterableInitithKeyAndValueTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import Foundation
import Testing
@testable import VCore

@Suite
nonisolated struct CaseIterableInitithKeyAndValueTests {
    // MARK: Tests
    @Test
    func test() {
        #expect(Gender(key: \.value, value: 0) == nil)
        #expect(Gender(key: \.value, value: 1) == Gender.male)
        #expect(Gender(key: \.value, value: 2) == Gender.female)
        #expect(Gender(key: \.value, value: 3) == nil)
    }
    
    // MARK: Types
    nonisolated private enum Gender: CaseIterable {
        // MARK: Cases
        case male
        case female

        // MARK: Properties
        var value: Int {
            switch self {
            case .male: 1
            case .female: 2
            }
        }
    }
}
