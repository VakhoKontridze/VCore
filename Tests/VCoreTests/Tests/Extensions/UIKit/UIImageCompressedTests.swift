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
    func testJPEG() {
        let image: UIImage = .init(size: .init(dimension: 100), color: .red)! // Force-unwrap
        let compressedImage: UIImage = image.jpegCompressed(quality: 0.75)! // Force-unwrap
        
        let imageData: Data = image.jpegData(compressionQuality: 1)! // Force-unwrap
        let compressedImageData: Data = compressedImage.jpegData(compressionQuality: 1)! // Force-unwrap
        
        XCTAssertLessThan(compressedImageData.count, imageData.count)
    }
}

#endif
