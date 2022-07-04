//
//  ColorBlendTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

import XCTest
import SwiftUI
@testable import VCore

// MARK: - Tests
@available(iOS 15.0, *)
@available(macOS 12.0, *)
@available(tvOS 15.0, *)
@available(watchOS 8.0, *)
final class ColorBlendTests: XCTestCase {
    func testBlend() {
        let input1R: CGFloat = 1/3
        let input1G: CGFloat = 1/3
        let input1B: CGFloat = 1/3
        let input1A: CGFloat = 1
        
        let input2R: CGFloat = 2/3
        let input2G: CGFloat = 2/3
        let input2B: CGFloat = 2/3
        let input2A: CGFloat = 1

        let outputR: CGFloat = (input1R + input2R) / 2
        let outputG: CGFloat = (input1G + input2G) / 2
        let outputB: CGFloat = (input1B + input2B) / 2
        let outputA: CGFloat = (input1A + input2A) / 2
        
        let color1: Color = .init(red: input1R, green: input1G, blue: input1B).opacity(input1A)
        let color2: Color = .init(red: input2R, green: input2G, blue: input2B).opacity(input2A)
        
        let result = Color.blend(color1, with: color2).rgbaValues
        
        XCTAssertEqual(result.red, outputR)
        XCTAssertEqual(result.green, outputG)
        XCTAssertEqual(result.blue, outputB)
        XCTAssertEqual(result.alpha, outputA)
    }
    
    func testBlendWeighted() {
        let input1R: CGFloat = 1/3
        let input1G: CGFloat = 1/3
        let input1B: CGFloat = 1/3
        let input1A: CGFloat = 1
        let ratio1: CGFloat = 0.4
        
        let input2R: CGFloat = 2/3
        let input2G: CGFloat = 2/3
        let input2B: CGFloat = 2/3
        let input2A: CGFloat = 1
        let ratio2: CGFloat = 0.6

        let outputR: CGFloat = input1R * ratio1 + input2R * ratio2
        let outputG: CGFloat = input1G * ratio1 + input2G * ratio2
        let outputB: CGFloat = input1B * ratio1 + input2B * ratio2
        let outputA: CGFloat = input1A * ratio1 + input2A * ratio2
        
        let color1: Color = .init(red: input1R, green: input1G, blue: input1B).opacity(input1A)
        let color2: Color = .init(red: input2R, green: input2G, blue: input2B).opacity(input2A)
        
        let result = Color.blend(color1, ratio1: ratio1, with: color2, ratio2: ratio2).rgbaValues
        
        XCTAssertEqual(result.red, outputR)
        XCTAssertEqual(result.green, outputG)
        XCTAssertEqual(result.blue, outputB)
        XCTAssertEqual(result.alpha, outputA)
    }
    
    func testLighten() {
        let inputR: CGFloat = 0.5
        let inputG: CGFloat = 0.5
        let inputB: CGFloat = 0.5
        let inputA: CGFloat = 1
        let value: CGFloat = 0.1

        let outputR: CGFloat = inputR + value
        let outputG: CGFloat = inputG + value
        let outputB: CGFloat = inputB + value
        let outputA: CGFloat = inputA
        
        let color: Color = .init(red: inputR, green: inputG, blue: inputB).opacity(inputA)
        
        let result = color.lighten(by: value).rgbaValues
        
        XCTAssertEqual(result.red, outputR)
        XCTAssertEqual(result.green, outputG)
        XCTAssertEqual(result.blue, outputB)
        XCTAssertEqual(result.alpha, outputA)
    }
    
    func testDarken() {
        let inputR: CGFloat = 0.5
        let inputG: CGFloat = 0.5
        let inputB: CGFloat = 0.5
        let inputA: CGFloat = 1
        let value: CGFloat = 0.1

        let outputR: CGFloat = inputR - value
        let outputG: CGFloat = inputG - value
        let outputB: CGFloat = inputB - value
        let outputA: CGFloat = inputA
        
        let color: Color = .init(red: inputR, green: inputG, blue: inputB).opacity(inputA)
        
        let result = color.darken(by: value).rgbaValues
        
        XCTAssertEqual(result.red, outputR)
        XCTAssertEqual(result.green, outputG)
        XCTAssertEqual(result.blue, outputB)
        XCTAssertEqual(result.alpha, outputA)
    }
}
