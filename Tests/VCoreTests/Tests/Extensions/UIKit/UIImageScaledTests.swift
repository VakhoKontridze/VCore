//
//  UIImageScaledTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit)

import XCTest
@testable import VCore

// MARK: - Tests
final class UIImageScaledTests: XCTestCase {
    func testScaledToWidth() {
        let image: UIImage = .init(
            color: .red,
            size: .init(width: 100, height: 200)
        )!
        
        let scaledDownImage: UIImage = image.scaled(toWidth: 50)!
        XCTAssertEqual(scaledDownImage.size, .init(width: 50, height: 100))
        
        let scaledUpImage: UIImage = image.scaled(toWidth: 200)!
        XCTAssertEqual(scaledUpImage.size, .init(width: 200, height: 400))
    }
    
    func testScaledToHeight() {
        let image: UIImage = .init(
            color: .red,
            size: .init(width: 200, height: 100)
        )!
        
        let scaledDownImage: UIImage = image.scaled(toHeight: 50)!
        XCTAssertEqual(scaledDownImage.size, .init(width: 100, height: 50))
        
        let scaledUpImage: UIImage = image.scaled(toHeight: 200)!
        XCTAssertEqual(scaledUpImage.size, .init(width: 400, height: 200))
    }
    
    func testScaledDownToWidth() {
        let image: UIImage = .init(
            color: .red,
            size: .init(width: 100, height: 200)
        )!
        
        let scaledImage: UIImage = image.scaledDown(toWidth: 100)!
        XCTAssertEqual(scaledImage.size, .init(width: 100, height: 200))
        
        let scaledDownImage: UIImage = image.scaledDown(toWidth: 50)!
        XCTAssertEqual(scaledDownImage.size, .init(width: 50, height: 100))
    }
    
    func testScaledDownToHeight() {
        let image: UIImage = .init(
            color: .red,
            size: .init(width: 200, height: 100)
        )!
        
        let scaledImage: UIImage = image.scaledDown(toHeight: 100)!
        XCTAssertEqual(scaledImage.size, .init(width: 200, height: 100))
        
        let scaledDownImage: UIImage = image.scaledDown(toHeight: 50)!
        XCTAssertEqual(scaledDownImage.size, .init(width: 100, height: 50))
    }
    
    func testScaledDownToDimension() {
        let image1: UIImage = .init(
            color: .red,
            size: .init(width: 100, height: 200)
        )!
        let scaledImageW: UIImage = image1.scaledDown(toDimension: 50)!
        XCTAssertEqual(scaledImageW.size, .init(width: 50, height: 100))
        
        let image2: UIImage = .init(
            color: .red,
            size: .init(width: 200, height: 100)
        )!
        let scaledImageH: UIImage = image2.scaledDown(toDimension: 50)!
        XCTAssertEqual(scaledImageH.size, .init(width: 100, height: 50))
    }
}

#endif
