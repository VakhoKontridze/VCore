//
//  SequenceContainsDuplicatesTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 23.01.24.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class SequenceContainsDuplicatesTests: XCTestCase {
    func test() {
        XCTAssertFalse([1, 3, 5].containsDuplicates)
        XCTAssertTrue([1, 1, 3, 5].containsDuplicates)
    }
}
