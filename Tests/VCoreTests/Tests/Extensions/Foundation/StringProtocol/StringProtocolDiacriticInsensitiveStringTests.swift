//
//  StringProtocolDiacriticInsensitiveStringTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class StringProtocolDiacriticInsensitiveStringTests: XCTestCase {
    func test() {
        XCTAssertEqual("À".diacriticInsensitiveString(), "A")
    }
}
