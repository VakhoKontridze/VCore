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
    func test() {
        let image: UIImage = .init(size: .init(dimension: 100), color: .red)! // fatalError
        let compressedImage: UIImage = image.compressed(quality: 0.75)! // fatalError
        
        let imageData: Data = image.jpegData(compressionQuality: 1)! // fatalError
        let compressedImageData: Data = compressedImage.jpegData(compressionQuality: 1)! // fatalError
        
        XCTAssertLessThan(compressedImageData.count, imageData.count)
    }
}

#endif
