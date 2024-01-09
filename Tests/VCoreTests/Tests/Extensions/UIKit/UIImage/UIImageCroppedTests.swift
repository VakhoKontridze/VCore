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
        guard
            let image: UIImage = .init(size: CGSize(dimension: 100), color: UIColor.red)
        else {
            VCoreLogError("Failed to generate test data")
            fatalError()
        }
        
        let croppedImage: UIImage = image.cropped(
            to: CGRect(
                origin: CGPoint(x: 25, y: 25),
                size: CGSize(dimension: 50)
            )
        )

        guard
            let croppedImageAverageColor: UIColor = croppedImage.averageColor
        else {
            VCoreLogError("Failed to generate test data")
            fatalError()
        }

        XCTAssertEqualColor(croppedImageAverageColor, UIColor.red)
    }
    
    func testSingleColorCroppedToSize() {
        guard
            let image: UIImage = .init(size: CGSize(dimension: 100), color: UIColor.red)
        else {
            VCoreLogError("Failed to generate test data")
            fatalError()
        }

        let croppedImage: UIImage = image.cropped(to: CGSize(dimension: 50))

        guard
            let croppedImageAverageColor: UIColor = croppedImage.averageColor
        else {
            VCoreLogError("Failed to generate test data")
            fatalError()
        }

        XCTAssertEqualColor(croppedImageAverageColor, UIColor.red)
    }
    
    func testMultiColorCroppedToRect() {
        guard
            let image1: UIImage = .init(size: CGSize(dimension: 100), color: UIColor.red),
            let image2: UIImage = .init(size: CGSize(dimension: 100), color: UIColor.green),
            let mergedImage: UIImage = .mergeHorizontally(image1, with: image2)
        else {
            VCoreLogError("Failed to generate test data")
            fatalError()
        }
        
        let croppedImage: UIImage = mergedImage.cropped(
            to: CGRect(
                origin: .zero,
                size: CGSize(dimension: 100)
            )
        )

        guard
            let croppedImageAverageColor: UIColor = croppedImage.averageColor
        else {
            VCoreLogError("Failed to generate test data")
            fatalError()
        }

        XCTAssertEqualColor(croppedImageAverageColor, UIColor.red)
    }
}

#endif
