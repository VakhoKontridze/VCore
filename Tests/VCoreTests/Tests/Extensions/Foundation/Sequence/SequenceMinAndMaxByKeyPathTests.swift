//
//  SequenceMinAndMaxByKeyPathTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.10.23.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class SequenceMinAndMaxByKeyPathTests: XCTestCase {
    // MARK: Test Data
    private struct Object: Equatable {
        let value: Int

        init(_ value: Int) { self.value = value }
    }

    // MARK: Tests
    func testMin() {
        let array: [Object] = [.init(1), .init(2), .init(3)]

        let element: Object? = array.min(by: \.value)

        XCTAssertEqual(element, Object(1))
    }

    func testMax() {
        let array: [Object] = [.init(1), .init(2), .init(3)]

        let element: Object? = array.max(by: \.value)

        XCTAssertEqual(element, Object(3))
    }
}
