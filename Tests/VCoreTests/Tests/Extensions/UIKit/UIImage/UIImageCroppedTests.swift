//
//  UIImageCroppedTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit) && !os(watchOS) // `UIImage.averageColor` doesn't work on watchOS

import XCTest
@testable import VCore

// MARK: - Tests
final class UIImageCroppedTests: XCTestCase {
    func testSingleColorCroppedToRect() {
        let image: UIImage = .init(size: CGSize(dimension: 100), color: .red)! // Force-unwrap
        
        let croppedImage: UIImage = image.cropped(
            to: CGRect(
                origin: CGPoint(x: 25, y: 25),
                size: CGSize(dimension: 50)
            )
        )
        
        XCTAssertEqualColor(croppedImage.averageColor!, .red) // Force-unwrap
    }
    
    func testSingleColorCroppedToSize() {
        let image: UIImage = .init(size: CGSize(dimension: 100), color: .red)! // Force-unwrap
        
        let croppedImage: UIImage = image.cropped(to: CGSize(dimension: 50))
        
        XCTAssertEqualColor(croppedImage.averageColor!, .red) // Force-unwrap
    }
    
    func testMultiColorCroppedToRect() {
        let image1: UIImage = .init(size: CGSize(dimension: 100), color: .red)! // Force-unwrap
        
        let image2: UIImage = .init(size: CGSize(dimension: 100), color: .blue)! // Force-unwrap
        
        let mergedImage: UIImage = .mergeHorizontally(image1, with: image2)!
        
        let croppedImage: UIImage = mergedImage.cropped(
            to: CGRect(
                origin: .zero,
                size: CGSize(dimension: 100)
            )
        )
        
        XCTAssertEqualColor(croppedImage.averageColor!, .red) // Force-unwrap
    }
}

#endif
