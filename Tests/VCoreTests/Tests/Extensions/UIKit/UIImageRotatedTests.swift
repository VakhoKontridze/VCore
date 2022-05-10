//
//  UIImageRotatedTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit)

import XCTest
@testable import VCore

// MARK: - Tests
final class UIImageRotatedTests: XCTestCase { // Not testing helper methods
    func test() {
        let image1: UIImage = .init(color: .red, size: .init(dimension: 100))!
        
        let image2: UIImage = .init(color: .blue, size: .init(dimension: 100))!
        
        let mergedImage: UIImage = .mergeHorizontally(image1, with: image2)!
        
        let rotatedImage: UIImage = mergedImage.rotated(by: .init(value: 90, unit: .degrees))!
        
        let croppedImage: UIImage = rotatedImage.cropped(to: .init(
            origin: .zero,
            size: .init(dimension: 100)
        ))
        
        XCTAssertEqualColor(croppedImage.averageColor!, .red)
    }
}

#endif
