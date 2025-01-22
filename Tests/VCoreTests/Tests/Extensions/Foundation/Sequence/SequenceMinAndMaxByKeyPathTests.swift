//
//  SequenceMinAndMaxByKeyPathTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.10.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct SequenceMinAndMaxByKeyPathTests {
    // MARK: Test Data
    private struct Object: Equatable {
        let value: Int
    }
    
    private let array: [Object] = [
        Object(value: 1),
        Object(value: 2),
        Object(value: 3)
    ]

    // MARK: Tests
    @Test
    func test() {
        #expect(array.min(by: \.value)?.value == 1)
        #expect(array.max(by: \.value)?.value == 3)
    }
}
