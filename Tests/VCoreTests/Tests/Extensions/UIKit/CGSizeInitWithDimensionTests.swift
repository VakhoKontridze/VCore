//
//  CGSizeInitWithDimensionTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class CGSizeInitWithDimensionTests: XCTestCase {
    func test() {
        let dimension: CGFloat = 100
        
        let size: CGSize = .init(dimension: dimension)
        
        XCTAssertEqual(size.width, dimension)
        XCTAssertEqual(size.height, dimension)
    }
}
