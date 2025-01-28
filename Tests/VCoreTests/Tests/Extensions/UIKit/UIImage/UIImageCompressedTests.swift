//
//  UIImageCompressedTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit)

import UIKit
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct UIImageCompressedTests {
    @Test
    func test() throws {
        let image: UIImage = try #require(
            UIImage(
                size: CGSize(dimension: 100),
                color: UIColor.red
            )
        )
        
        let imageData: Data = try #require(
            image.jpegData(compressionQuality: 1)
        )

        let compressedImage: UIImage = try #require(
            image.jpegCompressed(quality: 0.75)
        )

        let compressedImageData: Data = try #require(
            compressedImage.jpegData(compressionQuality: 1)
        )

        #expect(compressedImageData.count < imageData.count)
    }
}

#endif
