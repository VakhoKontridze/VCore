//
//  BoolToggledTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.09.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class BoolToggledTests: XCTestCase {
    func test() {
        XCTAssertEqual(false.toggled(), true)
        XCTAssertEqual(true.toggled(), false)
    }
}
