//
//  RangeInitWithBoundsTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.07.23.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class RangeInitWithBoundsTests: XCTestCase {
    func test() {
        let range: Range<Int> = .init(lower: 1, upper: 10)

        XCTAssertEqual(range, 1..<10)
    }
}
