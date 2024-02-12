//
//  ClosedRangeInitWithBoundsTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 05.08.23.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class ClosedRangeInitWithBoundsTests: XCTestCase {
    func test() {
        let range: ClosedRange<Int> = .init(lower: 1, upper: 10)

        XCTAssertEqual(range, 1...10)
    }
}
