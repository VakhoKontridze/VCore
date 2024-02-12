//
//  CGSizeWithReversedDimensionsTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.02.23.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class CGSizeWithReversedDimensionsTests: XCTestCase {
    func testConditionalFalse() {
        let size: CGSize = .init(width: 3, height: 4)

        let reversedSize: CGSize = size.withReversedDimensions(false)
        
        XCTAssertEqual(reversedSize.width, 3)
        XCTAssertEqual(reversedSize.height, 4)
    }
    
    func testConditionalTrue() {
        let size: CGSize = .init(width: 3, height: 4)
        
        let reversedSize: CGSize = size.withReversedDimensions(true)
        
        XCTAssertEqual(reversedSize.width, 4)
        XCTAssertEqual(reversedSize.height, 3)
    }
}
