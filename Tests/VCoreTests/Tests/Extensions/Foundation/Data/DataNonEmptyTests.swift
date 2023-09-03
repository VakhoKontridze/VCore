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
    func test() {
        XCTAssertNil(Data().nonEmpty)
        XCTAssertNotNil("data".data(using: .utf8)!.nonEmpty) // Force-unwrap
    }
}
