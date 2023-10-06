//
//  SequenceMinMaxByKeyPath.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.10.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class SequenceMinMaxByKeyPath: XCTestCase {
    // MARK: Test Data
    private struct Object: Equatable {
        let value: Int

        init(_ value: Int) { self.value = value }
    }

    // MARK: Tests
    func testMin() {
        let input: [Object] = [.init(1), .init(2), .init(3)]
        let output: Object = .init(1)

        let result: Object? = input.min(by: \.value)

        XCTAssertEqual(result, output)
    }

    func testMax() {
        let input: [Object] = [.init(1), .init(2), .init(3)]
        let output: Object = .init(3)

        let result: Object? = input.max(by: \.value)

        XCTAssertEqual(result, output)
    }
}
