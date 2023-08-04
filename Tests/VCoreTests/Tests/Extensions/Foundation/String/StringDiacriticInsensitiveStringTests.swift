//
//  StringDiacriticInsensitiveStringTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

import XCTest
@testable import VCore

// MARK: - String Diacritic Insensitive String Tests
final class StringDiacriticInsensitiveStringTests: XCTestCase {
    func test() {
        XCTAssertEqual("À".diacriticInsensitiveString(), "A")
    }
}
