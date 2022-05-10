//
//  UIImageInitWithColorTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit)

import XCTest
@testable import VCore

// MARK: - Tests
final class UIImageInitWithColorTests: XCTestCase {
    func test() {
        let dimension: CGFloat = 100
        let color: UIColor = .red
        
        let image: UIImage = .init(color: color, size: .init(dimension: dimension))!

        XCTAssertEqual(image.size, .init(dimension: dimension))
        XCTAssertEqualColor(image.averageColor!, color)
    }
}

#endif
