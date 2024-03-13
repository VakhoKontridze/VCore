//
//  KeyPathInitializableEnumerationTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class KeyPathInitializableEnumerationTests: XCTestCase {
    // MARK: Test Data
    private enum Gender: KeyPathInitializableEnumeration {
        case male
        case female

        var value: Int {
            switch self {
            case .male: 1
            case .female: 2
            }
        }
    }
    
    // MARK: Tests
    func test() {
        XCTAssertNil(Gender(key: \.value, value: 0))
        XCTAssertEqual(Gender(key: \.value, value: 1), Gender.male)
        XCTAssertEqual(Gender(key: \.value, value: 2), Gender.female)
        XCTAssertNil(Gender(key: \.value, value: 3))
    }
}
