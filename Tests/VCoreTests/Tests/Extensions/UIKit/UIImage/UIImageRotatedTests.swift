//
//  UIImageRotatedTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit) && !os(watchOS) // `UIImage.averageColor` doesn't work on watchOS

import Foundation
import OSLog
import XCTest
@testable import VCore

// MARK: - Tests
final class UIImageRotatedTests: XCTestCase {
    func test() throws {
        guard
            let image1: UIImage = .init(size: CGSize(dimension: 100), color: UIColor.red),
            let image2: UIImage = .init(size: CGSize(dimension: 100), color: UIColor.green),
            let mergedImage: UIImage = .mergeHorizontally(image1, with: image2)
        else {
            Logger.uiImageRotatedTests.critical("Failed to generate test data")
            fatalError()
        }
        
        let rotatedImage: UIImage = try XCTUnwrap(
            mergedImage.rotated(by: Measurement(value: 90, unit: .degrees))
        )

        let croppedImage: UIImage = rotatedImage.cropped(
            to: CGRect(
                origin: .zero,
                size: CGSize(dimension: 100)
            )
        )
        
        guard
            let croppedImageAverageColor: UIColor = croppedImage.averageColor
        else {
            Logger.uiImageRotatedTests.critical("Failed to generate test data")
            fatalError()
        }

        XCTAssertEqualColor(croppedImageAverageColor, UIColor.red)
    }
}

#endif
