//
//  NumericNonZeroTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 26.11.23.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class NumericNonZeroTests: XCTestCase {
    func test() {
        XCTAssertNil(0.nonZero)
        XCTAssertNotNil(1.nonZero)
    }
}
