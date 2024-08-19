//
//  SetInsertSequenceTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 18.12.23.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class SetInsertSequenceTests: XCTestCase {
    func test() {
        let set: Set<Int> = [1, 2]

        var insertedSet: Set<Int> = set
        insertedSet.insert(contentsOf: [3, 4])

        XCTAssertEqual(insertedSet, [1, 2, 3, 4])
    }
}
