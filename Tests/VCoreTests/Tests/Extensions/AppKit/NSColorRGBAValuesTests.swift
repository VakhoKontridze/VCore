//
//  NSColorRGBAValuesTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 04.07.22.
//

#if canImport(AppKit)

import XCTest
import AppKit
@testable import VCore

// MARK: - Tests
final class NSColorRGBAValuesTests: XCTestCase {
    func testValues() {
        let inputR: CGFloat = 0.1
        let inputG: CGFloat = 0.2
        let inputB: CGFloat = 0.3
        let inputA: CGFloat = 0.4
        
        let color: NSColor = .init(red: inputR, green: inputG, blue: inputB, alpha: inputA)
        
        let result = color.rgbaValues
        
        XCTAssertEqual(result.red, inputR)
        XCTAssertEqual(result.green, inputG)
        XCTAssertEqual(result.blue, inputB)
        XCTAssertEqual(result.alpha, inputA)
    }
    
    func testComponents() {
        let inputR: Int = 10
        let inputG: Int = 20
        let inputB: Int = 30
        let inputA: CGFloat = 0.4
        
        let color: NSColor = .init(red: CGFloat(inputR)/255, green: CGFloat(inputG)/255, blue: CGFloat(inputB)/255, alpha: inputA)
        
        let result = color.rgbaComponents
        
        XCTAssertEqual(result.red, inputR)
        XCTAssertEqual(result.green, inputG)
        XCTAssertEqual(result.blue, inputB)
        XCTAssertEqual(result.alpha, inputA)
    }
    
    func testISRGBAEqual() {
        XCTAssertTrue(
            NSColor.red.usingColorSpace(.deviceRGB)!
                .isRGBAEqual(to: .red.usingColorSpace(.deviceRGB)!)
        )
        
        XCTAssertFalse(
            NSColor.red.usingColorSpace(.deviceRGB)!
                .isRGBAEqual(to: .blue.usingColorSpace(.deviceRGB)!)
        )
    }
}

#endif
