//
//  DataNonEmptyTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.09.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class DataNonEmptyTests: XCTestCase {
    func testNil() {
        XCTAssertNil(Data().nonEmpty)
    }

    func testNotNil() {
        guard let data: Data = "data".data(using: .utf8) else {
            VCoreLogError("Failed to generate test data")
            fatalError()
        }

        XCTAssertNotNil(data.nonEmpty)
    }
}
