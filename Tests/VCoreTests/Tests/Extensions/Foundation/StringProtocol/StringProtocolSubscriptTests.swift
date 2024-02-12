//
//  StringProtocolSubscriptTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class StringProtocolSubscriptTests: XCTestCase {
    func testGet() {
        XCTAssertEqual("Lorem Ipsum"[0], "L")
    }
    
    func testSet() {
        let string: String = "Lorem ipsum"

        var replacedString: String = string
        replacedString[0] = "l"

        XCTAssertEqual(replacedString, "lorem ipsum")
    }
}
