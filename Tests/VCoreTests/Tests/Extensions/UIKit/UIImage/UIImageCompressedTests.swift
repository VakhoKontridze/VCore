//
//  UIImageCompressedTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit)

import XCTest
@testable import VCore

// MARK: - Tests
final class UIImageCompressedTests: XCTestCase {
    func testJPEG() throws {
        guard
            let image: UIImage = .init(size: CGSize(dimension: 100), color: UIColor.red),
            let imageData: Data = image.jpegData(compressionQuality: 1)
        else {
            VCoreLogError("Failed to generate test data")
            fatalError()
        }

        let compressedImage: UIImage = try XCTUnwrap(
            image.jpegCompressed(quality: 0.75)
        )

        guard
            let compressedImageData: Data = compressedImage.jpegData(compressionQuality: 1)
        else {
            VCoreLogError("Failed to generate test data")
            fatalError()
        }

        XCTAssertLessThan(compressedImageData.count, imageData.count)
    }
}

#endif
