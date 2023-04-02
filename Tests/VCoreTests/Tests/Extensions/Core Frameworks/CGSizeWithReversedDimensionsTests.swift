//
//  CGSizeWithReversedDimensionsTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.02.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class CGSizeWithReversedDimensionsTests: XCTestCase {
    // MARK: Test Data
    private let inputW: CGFloat = 3
    private let inputH: CGFloat = 4
    
    private let outputW: CGFloat = 4
    private let outputH: CGFloat = 3
    
    // MARK: Tests
    func testConditionalFalse() {
        let result: CGSize = .init(width: inputW, height: inputH)
            .withReversedDimensions(false)
        
        XCTAssertNotEqual(result.width, outputW)
        XCTAssertNotEqual(result.height, outputH)
    }
    
    func testConditionalTrue() {
        let result: CGSize = .init(width: inputW, height: inputH)
            .withReversedDimensions(true)
        
        XCTAssertEqual(result.width, outputW)
        XCTAssertEqual(result.height, outputH)
    }
}
