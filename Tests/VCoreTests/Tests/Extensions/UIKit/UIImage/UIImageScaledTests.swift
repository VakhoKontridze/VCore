//
//  UIImageScaledTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit)

import Foundation
import OSLog
import XCTest
@testable import VCore

// MARK: - Tests
final class UIImageScaledTests: XCTestCase {
    func testScaledToWidth() throws {
        guard
            let image: UIImage = .init(
                size: CGSize(width: 100, height: 200),
                color: UIColor.red
            )
        else {
            Logger.uiImageScaledTests.critical("Failed to generate test data")
            fatalError()
        }

        let scaledDownImage: UIImage = try XCTUnwrap(
            image.scaled(toWidth: 50)
        )
        XCTAssertEqual(scaledDownImage.size, CGSize(width: 50, height: 100))
        
        let scaledUpImage: UIImage = try XCTUnwrap(
            image.scaled(toWidth: 200)
        )
        XCTAssertEqual(scaledUpImage.size, CGSize(width: 200, height: 400))
    }
    
    func testScaledToHeight() throws {
        guard
            let image: UIImage = .init(
                size: CGSize(width: 200, height: 100),
                color: UIColor.red
            )
        else {
            Logger.uiImageScaledTests.critical("Failed to generate test data")
            fatalError()
        }

        let scaledDownImage: UIImage = try XCTUnwrap(
            image.scaled(toHeight: 50)
        )
        XCTAssertEqual(scaledDownImage.size, CGSize(width: 100, height: 50))
        
        let scaledUpImage: UIImage = try XCTUnwrap(
            image.scaled(toHeight: 200)
        )
        XCTAssertEqual(scaledUpImage.size, CGSize(width: 400, height: 200))
    }
    
    func testScaledDownToWidth() throws {
        guard
            let image: UIImage = .init(
                size: CGSize(width: 100, height: 200),
                color: UIColor.red
            )
        else {
            Logger.uiImageScaledTests.critical("Failed to generate test data")
            fatalError()
        }

        let scaledImage: UIImage = try XCTUnwrap(
            image.scaledDown(toWidth: 100)
        )
        XCTAssertEqual(scaledImage.size, CGSize(width: 100, height: 200))
        
        let scaledDownImage: UIImage = try XCTUnwrap(
            image.scaledDown(toWidth: 50)
        )
        XCTAssertEqual(scaledDownImage.size, CGSize(width: 50, height: 100))
    }
    
    func testScaledDownToHeight() throws {
        guard
            let image: UIImage = .init(
                size: CGSize(width: 200, height: 100),
                color: UIColor.red
            )
        else {
            Logger.uiImageScaledTests.critical("Failed to generate test data")
            fatalError()
        }

        let scaledImage: UIImage = try XCTUnwrap(
            image.scaledDown(toHeight: 100)
        )
        XCTAssertEqual(scaledImage.size, CGSize(width: 200, height: 100))
        
        let scaledDownImage: UIImage = try XCTUnwrap(
            image.scaledDown(toHeight: 50)
        )
        XCTAssertEqual(scaledDownImage.size, CGSize(width: 100, height: 50))
    }
    
    func testScaledDownToDimension() throws {
        guard
            let image1: UIImage = .init(
                size: CGSize(width: 100, height: 200),
                color: UIColor.red
            )
        else {
            Logger.uiImageScaledTests.critical("Failed to generate test data")
            fatalError()
        }

        let scaledImageW: UIImage = try XCTUnwrap(
            image1.scaledDown(toDimension: 50)
        )
        XCTAssertEqual(scaledImageW.size, CGSize(width: 50, height: 100))
        

        guard
            let image2: UIImage = .init(
                size: CGSize(width: 200, height: 100),
                color: UIColor.red
            )
        else {
            Logger.uiImageScaledTests.critical("Failed to generate test data")
            fatalError()
        }

        let scaledImageH: UIImage = try XCTUnwrap(
            image2.scaledDown(toDimension: 50)
        )
        XCTAssertEqual(scaledImageH.size, CGSize(width: 100, height: 50))
    }
}

#endif
