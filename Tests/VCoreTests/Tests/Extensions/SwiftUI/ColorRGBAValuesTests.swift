//
//  ColorRGBAValuesTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

import XCTest
@testable import VCore
import SwiftUI

// MARK: - Tests
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
final class ColorRGBAValuesTests: XCTestCase {
    func testValues() {
        let inputR: CGFloat = 0.1
        let inputG: CGFloat = 0.2
        let inputB: CGFloat = 0.3
        let inputA: CGFloat = 0.4
        
        let color: Color = .init(red: inputR, green: inputG, blue: inputB).opacity(inputA)
        
        let result = color.rgbaValues
        
        XCTAssertEqual(result.red, inputR, accuracy: pow(10, -5))
        XCTAssertEqual(result.green, inputG, accuracy: pow(10, -5))
        XCTAssertEqual(result.blue, inputB, accuracy: pow(10, -5))
        XCTAssertEqual(result.alpha, inputA)
    }
    
    func testComponents() {
        let accuracy: Int = { // Colorspace conversion on `macOS` may cause issues
#if os(macOS)
            return 1
#else
            return 0
#endif
        }()
        
        let inputR: Int = 10
        let inputG: Int = 20
        let inputB: Int = 30
        let inputA: CGFloat = 0.4
        
        let color: Color = .init(red: .init(inputR)/255, green: .init(inputG)/255, blue: .init(inputB)/255).opacity(inputA)
        
        let result = color.rgbaComponents
        
        XCTAssertEqual(result.red, inputR, accuracy: accuracy)
        XCTAssertEqual(result.green, inputG, accuracy: accuracy)
        XCTAssertEqual(result.blue, inputB, accuracy: accuracy)
        XCTAssertEqual(result.alpha, inputA)
    }
    
    func testISRGBAEqual() {
        XCTAssertTrue(Color.red.isRGBAEqual(to: .red))
        XCTAssertFalse(Color.red.isRGBAEqual(to: .blue))
    }
}
