//
//  ColorRGBAValuesTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

import SwiftUI
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct ColorRGBAValuesTests {
    @Test
    func testValues() {
        let color: Color = .init(red: 0.1, green: 0.2, blue: 0.3, opacity: 0.4)
        
        let values = color.rgbaValues
        
        // Direct comparison gives floating-point issues, so equality with tolerance must be used
        #expect(areEqual(values.red, 0.1, tolerance: pow(10, -5)))
        #expect(areEqual(values.green, 0.2, tolerance: pow(10, -5)))
        #expect(areEqual(values.blue, 0.3, tolerance: pow(10, -5)))
        #expect(areEqual(values.alpha, 0.4, tolerance: pow(10, -5)))
    }
    
    @Test
    func testComponents() {
        let accuracy: Int = { // Colorspace conversion on macOS may cause issues
#if os(macOS)
            1
#else
            0
#endif
        }()
        
        let color: Color = .init(red: 10.0/255, green: 20.0/255, blue: 30.0/255, opacity: 0.4)
        
        let components = color.rgbaComponents
        
        // Direct comparison gives color accuracy and floating-point issues on macOS, so equality with tolerance must be used
        #expect(areEqual(components.red, 10, tolerance: accuracy))
        #expect(areEqual(components.green, 20, tolerance: accuracy))
        #expect(areEqual(components.blue, 30, tolerance: accuracy))
        #expect(areEqual(components.alpha, 0.4, tolerance: pow(10, -5)))
    }
    
    @Test
    func testISRGBAEqual() {
        #expect(Color.red.isRGBAEqual(to: .red))
        #expect(!Color.red.isRGBAEqual(to: .blue))
    }
}
