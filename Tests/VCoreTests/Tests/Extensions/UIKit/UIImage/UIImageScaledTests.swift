//
//  UIImageScaledTests.swift
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
struct UIImageScaledTests {
    @Test
    func testScaledToWidth() throws {
        let image: UIImage = try #require(
            UIImage(
                size: CGSize(width: 100, height: 200),
                color: UIColor.red
            )
        )
        
        let scaledDownImage: UIImage = try #require(
            image.scaled(toWidth: 50)
        )
        #expect(scaledDownImage.size == CGSize(width: 50, height: 100))
        
        let scaledUpImage: UIImage = try #require(
            image.scaled(toWidth: 200)
        )
        #expect(scaledUpImage.size == CGSize(width: 200, height: 400))
    }
    
    @Test
    func testScaledToHeight() throws {
        let image: UIImage = try #require(
            UIImage(
                size: CGSize(width: 200, height: 100),
                color: UIColor.red
            )
        )

        let scaledDownImage: UIImage = try #require(
            image.scaled(toHeight: 50)
        )
        #expect(scaledDownImage.size == CGSize(width: 100, height: 50))
        
        let scaledUpImage: UIImage = try #require(
            image.scaled(toHeight: 200)
        )
        #expect(scaledUpImage.size == CGSize(width: 400, height: 200))
    }
    
    @Test
    func testScaledDownToWidth() throws {
        let image: UIImage = try #require(
            UIImage(
                size: CGSize(width: 100, height: 200),
                color: UIColor.red
            )
        )

        let scaledImage: UIImage = try #require(
            image.scaledDown(toWidth: 100)
        )
        #expect(scaledImage.size == CGSize(width: 100, height: 200))
        
        let scaledDownImage: UIImage = try #require(
            image.scaledDown(toWidth: 50)
        )
        #expect(scaledDownImage.size == CGSize(width: 50, height: 100))
    }
    
    @Test
    func testScaledDownToHeight() throws {
        let image: UIImage = try #require(
            UIImage(
                size: CGSize(width: 200, height: 100),
                color: UIColor.red
            )
        )
        
        let scaledImage: UIImage = try #require(
            image.scaledDown(toHeight: 100)
        )
        #expect(scaledImage.size == CGSize(width: 200, height: 100))
        
        let scaledDownImage: UIImage = try #require(
            image.scaledDown(toHeight: 50)
        )
        #expect(scaledDownImage.size == CGSize(width: 100, height: 50))
    }
    
    @Test
    func testScaledDownToDimension() throws {
        let image1: UIImage = try #require(
            UIImage(
                size: CGSize(width: 100, height: 200),
                color: UIColor.red
            )
        )
        
        let scaledImageW: UIImage = try #require(
            image1.scaledDown(toDimension: 50)
        )
        #expect(scaledImageW.size == CGSize(width: 50, height: 100))
        

        let image2: UIImage = try #require(
            UIImage(
                size: CGSize(width: 200, height: 100),
                color: UIColor.red
            )
        )

        let scaledImageH: UIImage = try #require(
            image2.scaledDown(toDimension: 50)
        )
        #expect(scaledImageH.size == CGSize(width: 100, height: 50))
    }
}

#endif
