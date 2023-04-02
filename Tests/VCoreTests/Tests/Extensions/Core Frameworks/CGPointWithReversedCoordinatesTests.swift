//
//  CGPointWithReversedCoordinatesTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.04.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class CGPointWithReversedCoordinatesTests: XCTestCase {
    // MARK: Test Data
    private let inputX: CGFloat = 3
    private let inputY: CGFloat = 4
    
    private let outputX: CGFloat = 4
    private let outputY: CGFloat = 3
    
    // MARK: Tests
    func testConditionalFalse() {
        let result: CGPoint = .init(x: inputX, y: inputY)
            .withReversedCoordinates(false)
        
        XCTAssertEqual(result.x, outputX)
        XCTAssertEqual(result.y, outputY)
    }
    
    func testConditionalTrue() {
        let result: CGPoint = .init(x: inputX, y: inputY)
            .withReversedCoordinates(true)
        
        XCTAssertEqual(result.x, outputX)
        XCTAssertEqual(result.y, outputY)
    }
}
