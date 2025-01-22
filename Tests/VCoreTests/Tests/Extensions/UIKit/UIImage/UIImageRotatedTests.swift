//
//  UIImageRotatedTests.swift
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
struct UIImageRotatedTests {
    @Test
    func test() throws {
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

        let rotatedImage: UIImage = try #require(
            mergedImage.rotated(by: Measurement(value: 90, unit: .degrees))
        )

        let croppedImage: UIImage = rotatedImage.cropped(
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
