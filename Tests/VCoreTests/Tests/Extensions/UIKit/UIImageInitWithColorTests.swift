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
        
        let image: UIImage = .init(size: .init(dimension: dimension), color: color)! // Force-unwrap

        XCTAssertEqual(image.size, CGSize(dimension: dimension))
        
#if !os(watchOS)
        XCTAssertEqualColor(image.averageColor!, color) // Force-unwrap
#endif
    }
}

#endif
