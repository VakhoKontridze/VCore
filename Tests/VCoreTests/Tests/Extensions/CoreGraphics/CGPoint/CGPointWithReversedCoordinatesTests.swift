//
//  CGPointWithReversedCoordinatesTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.04.23.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class CGPointWithReversedCoordinatesTests: XCTestCase {
    func testConditionalFalse() {
        let point: CGPoint = .init(x: 3, y: 4)

        let reversedPoint: CGPoint = point.withReversedCoordinates(false)
        
        XCTAssertEqual(reversedPoint.x, 3)
        XCTAssertEqual(reversedPoint.y, 4)
    }
    
    func testConditionalTrue() {
        let point: CGPoint = .init(x: 3, y: 4)

        let reversedPoint: CGPoint = point.withReversedCoordinates(true)
        
        XCTAssertEqual(reversedPoint.x, 4)
        XCTAssertEqual(reversedPoint.y, 3)
    }
}
