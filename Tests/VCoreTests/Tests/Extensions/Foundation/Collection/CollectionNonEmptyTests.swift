//
//  CollectionNonEmptyTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 17.11.23.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class CollectionNonEmptyTests: XCTestCase {
    func test() {
        XCTAssertNil(Array<Int>().nonEmpty)
        XCTAssertNotNil([1, 2, 3].nonEmpty)
    }
}
