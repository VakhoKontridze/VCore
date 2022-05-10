//
//  KVInitializableEnumerationTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class KVInitializableEnumerationTests: XCTestCase {
    private enum SomeEnum: KVInitializableEnumeration {
        case first
        case second

        var someProperty: Int {
            switch self {
            case .first: return 1
            case .second: return 2
            }
        }
    }

    func test() {
        XCTAssertNil(SomeEnum.aCase(key: \.someProperty, value: 0))
        XCTAssertEqual(SomeEnum.aCase(key: \.someProperty, value: 1), .first)
        XCTAssertEqual(SomeEnum.aCase(key: \.someProperty, value: 2), .second)
        XCTAssertNil(SomeEnum.aCase(key: \.someProperty, value: 3))
    }
}
