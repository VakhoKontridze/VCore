//
//  UIImageRotatedTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit) && !os(watchOS)// averageColor doesn't work on watchOS

import XCTest
@testable import VCore

// MARK: - Tests
final class UIImageRotatedTests: XCTestCase { // Not testing helper methods
    func test() {
        let image1: UIImage = .init(size: .init(dimension: 100), color: .red)! // Force-unwrap
        
        let image2: UIImage = .init(size: .init(dimension: 100), color: .blue)! // Force-unwrap
        
        let mergedImage: UIImage = .mergeHorizontally(image1, with: image2)! // Force-unwrap
        
        let rotatedImage: UIImage = mergedImage.rotated(by: .init(value: 90, unit: .degrees))! // Force-unwrap
        
        let croppedImage: UIImage = rotatedImage.cropped(to: .init(
            origin: .zero,
            size: .init(dimension: 100)
        ))
        
        XCTAssertEqualColor(croppedImage.averageColor!, .red) // Force-unwrap
    }
}

#endif
