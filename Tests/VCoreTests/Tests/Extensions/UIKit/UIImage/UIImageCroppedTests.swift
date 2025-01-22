//
//  UIImageCroppedTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit) && !os(watchOS) // `UIImage.averageColor` doesn't work on watchOS

import UIKit
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct UIImageCroppedTests {
    @Test
    func testSingleColorCroppedToRect() throws {
        let image: UIImage = try #require(
            UIImage(
                size: CGSize(dimension: 100),
                color: UIColor.red
            )
        )
        
        let croppedImage: UIImage = image.cropped(
            to: CGRect(
                origin: CGPoint(x: 25, y: 25),
                size: CGSize(dimension: 50)
            )
        )

        let croppedImageAverageColor: UIColor = try #require(
            croppedImage.averageColor
        )

        #expect(croppedImageAverageColor == UIColor.red)
    }
    
    @Test
    func testSingleColorCroppedToSize() throws {
        let image: UIImage = try #require(
            UIImage(
                size: CGSize(dimension: 100),
                color: UIColor.red
            )
        )

        let croppedImage: UIImage = image.cropped(to: CGSize(dimension: 50))

        let croppedImageAverageColor: UIColor = try #require(
            croppedImage.averageColor
        )

        #expect(croppedImageAverageColor == UIColor.red)
    }
    
    @Test
    func testMultiColorCroppedToRect() throws {
        let image1: UIImage = try #require(
            UIImage(
                size: CGSize(dimension: 100),
                color: UIColor.red
            )
        )
        let image2: UIImage = try #require(
            UIImage(
                size: CGSize(dimension: 100),
                color: UIColor.blue
            )
        )
        let mergedImage: UIImage = try #require(
            .mergeHorizontally(image1, with: image2)
        )
        
        let croppedImage: UIImage = mergedImage.cropped(
            to: CGRect(
                origin: .zero,
                size: CGSize(dimension: 100)
            )
        )

        let croppedImageAverageColor: UIColor = try #require(
            croppedImage.averageColor
        )

        #expect(croppedImageAverageColor == UIColor.red)
    }
}

#endif
