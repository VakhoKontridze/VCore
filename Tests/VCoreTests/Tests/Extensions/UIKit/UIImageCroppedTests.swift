//
//  UIImageCroppedTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit)

import XCTest
@testable import VCore

// MARK: - Tests
final class UIImageCroppedTests: XCTestCase {
    func testSingleColorCroppedToRect() {
        let image: UIImage = .init(color: .red, size: .init(dimension: 100))!
        
        let croppedImage: UIImage = image.cropped(to: .init(
            origin: .init(x: 25, y: 25),
            size: .init(dimension: 50)
        ))
        
        XCTAssertEqualColor(croppedImage.averageColor!, .red)
    }
    
    func testSingleColorCroppedToSize() {
        let image: UIImage = .init(color: .red, size: .init(dimension: 100))!
        
        let croppedImage: UIImage = image.cropped(to: .init(dimension: 50))
        
        XCTAssertEqualColor(croppedImage.averageColor!, .red)
    }
    
    func testMultiColorCroppedToRect() {
        let image1: UIImage = .init(color: .red, size: .init(dimension: 100))!
        
        let image2: UIImage = .init(color: .blue, size: .init(dimension: 100))!
        
        let mergedImage: UIImage = .mergeHorizontally(image1, with: image2)!
        
        let croppedImage: UIImage = mergedImage.cropped(to: .init(
            origin: .zero,
            size: .init(dimension: 100)
        ))
        
        XCTAssertEqualColor(croppedImage.averageColor!, .red)
    }
}

#endif
