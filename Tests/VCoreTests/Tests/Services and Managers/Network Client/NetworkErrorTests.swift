//
//  NetworkErrorTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class NetworkErrorTests: XCTestCase {
    func testErrorCodes() {
        let codes: [Int] = NetworkError.allCases.map { $0.code }
        
        XCTAssertTrue(codes.isUnique)
    }
}
