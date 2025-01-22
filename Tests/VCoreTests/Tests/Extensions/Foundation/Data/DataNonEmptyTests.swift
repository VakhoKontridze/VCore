//
//  DataNonEmptyTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 03.09.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct DataNonEmptyTests {
    @Test
    func testNil() {
        #expect(Data().nonEmpty == nil)
    }

    @Test
    func testNotNil() throws {
        let data: Data = try #require(
            "data".data(using: .utf8)
        )

        #expect(data.nonEmpty != nil)
    }
}
