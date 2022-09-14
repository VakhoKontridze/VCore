//
//  UIImageCroppedTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit) && !os(watchOS) // averageColor doesn't work on watchOS

import XCTest
@testable import VCore

// MARK: - Tests
final class UIImageCroppedTests: XCTestCase {
    func testSingleColorCroppedToRect() {
        let image: UIImage = .init(size: .init(dimension: 100), color: .red)! // Force-unwrap
        
        let croppedImage: UIImage = image.cropped(to: .init(
            origin: .init(x: 25, y: 25),
            size: .init(dimension: 50)
        ))
        
        XCTAssertEqualColor(croppedImage.averageColor!, .red) // Force-unwrap
    }
    
    func testSingleColorCroppedToSize() {
        let image: UIImage = .init(size: .init(dimension: 100), color: .red)! // Force-unwrap
        
        let croppedImage: UIImage = image.cropped(to: .init(dimension: 50))
        
        XCTAssertEqualColor(croppedImage.averageColor!, .red) // Force-unwrap
    }
    
    func testMultiColorCroppedToRect() {
        let image1: UIImage = .init(size: .init(dimension: 100), color: .red)! // Force-unwrap
        
        let image2: UIImage = .init(size: .init(dimension: 100), color: .blue)! // Force-unwrap
        
        let mergedImage: UIImage = .mergeHorizontally(image1, with: image2)!
        
        let croppedImage: UIImage = mergedImage.cropped(to: .init(
            origin: .zero,
            size: .init(dimension: 100)
        ))
        
        XCTAssertEqualColor(croppedImage.averageColor!, .red) // Force-unwrap
    }
}

#endif
