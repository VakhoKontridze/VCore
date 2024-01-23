//
//  ColorRGBAValuesTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

import SwiftUI
import XCTest
@testable import VCore

// MARK: - Tests
final class ColorRGBAValuesTests: XCTestCase {
    func testValues() {
        let color: Color = .init(red: 0.1, green: 0.2, blue: 0.3, opacity: 0.4)

        let values = color.rgbaValues

        XCTAssertEqual(values.red, 0.1, accuracy: pow(10, -5))
        XCTAssertEqual(values.green, 0.2, accuracy: pow(10, -5))
        XCTAssertEqual(values.blue, 0.3, accuracy: pow(10, -5))
        XCTAssertEqual(values.alpha, 0.4, accuracy: pow(10, -5))
    }
    
    func testComponents() {
        let accuracy: Int = { // Colorspace conversion on `macOS` may cause issues
#if os(macOS)
            1
#else
            0
#endif
        }()
        
        let color: Color = .init(red: 10.0/255, green: 20.0/255, blue: 30.0/255, opacity: 0.4)

        let components = color.rgbaComponents

        XCTAssertEqual(components.red, 10, accuracy: accuracy)
        XCTAssertEqual(components.green, 20, accuracy: accuracy)
        XCTAssertEqual(components.blue, 30, accuracy: accuracy)
        XCTAssertEqual(components.alpha, 0.4, accuracy: pow(10, -5))
    }
    
    func testISRGBAEqual() {
        XCTAssertTrue(Color.red.isRGBAEqual(to: .red))
        XCTAssertFalse(Color.red.isRGBAEqual(to: .blue))
    }
}
