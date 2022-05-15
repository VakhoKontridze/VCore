//
//  MultiPartFormDataErrorTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 15.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class MultiPartFormDataErrorTests: XCTestCase {
    func testErrorCodes() {
        let codes: [Int] = MultiPartFormDataError.allCases.map { $0.code }
        
        XCTAssertTrue(codes.isUnique)
    }
}
