//
//  NSColorBlendTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 04.07.22.
//

#if canImport(AppKit)

import XCTest
import AppKit
@testable import VCore

// MARK: - Tests
final class NSColorBlendTests: XCTestCase {
    func testBlend() {
        let input1R: CGFloat = 1/3
        let input1G: CGFloat = 1/3
        let input1B: CGFloat = 1/3
        let input1A: CGFloat = 1
        
        let input2R: CGFloat = 2/3
        let input2G: CGFloat = 2/3
        let input2B: CGFloat = 2/3
        let input2A: CGFloat = 1

        let ourputR: CGFloat = (input1R + input2R) / 2
        let ourputG: CGFloat = (input1G + input2G) / 2
        let ourputB: CGFloat = (input1B + input2B) / 2
        let ourputA: CGFloat = (input1A + input2A) / 2
        
        let color1: NSColor = .init(red: input1R, green: input1G, blue: input1B, alpha: input1A)
        let color2: NSColor = .init(red: input2R, green: input2G, blue: input2B, alpha: input2A)
        
        let result = NSColor.blend(color1, with: color2).rgbaValues
        
        XCTAssertEqual(result.red, ourputR)
        XCTAssertEqual(result.green, ourputG)
        XCTAssertEqual(result.blue, ourputB)
        XCTAssertEqual(result.alpha, ourputA)
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

        let ourputR: CGFloat = input1R * ratio1 + input2R * ratio2
        let ourputG: CGFloat = input1G * ratio1 + input2G * ratio2
        let ourputB: CGFloat = input1B * ratio1 + input2B * ratio2
        let ourputA: CGFloat = input1A * ratio1 + input2A * ratio2
        
        let color1: NSColor = .init(red: input1R, green: input1G, blue: input1B, alpha: input1A)
        let color2: NSColor = .init(red: input2R, green: input2G, blue: input2B, alpha: input2A)
        
        let result = NSColor.blend(color1, ratio1: ratio1, with: color2, ratio2: ratio2).rgbaValues
        
        XCTAssertEqual(result.red, ourputR)
        XCTAssertEqual(result.green, ourputG)
        XCTAssertEqual(result.blue, ourputB)
        XCTAssertEqual(result.alpha, ourputA)
    }
    
    func testLighten() {
        let inputR: CGFloat = 0.5
        let inputG: CGFloat = 0.5
        let inputB: CGFloat = 0.5
        let inputA: CGFloat = 1
        let value: CGFloat = 0.1

        let ourputR: CGFloat = inputR + value
        let ourputG: CGFloat = inputG + value
        let ourputB: CGFloat = inputB + value
        let ourputA: CGFloat = inputA
        
        let color: NSColor = .init(red: inputR, green: inputG, blue: inputB, alpha: inputA)
        
        let result = color.lighten(by: value).rgbaValues
        
        XCTAssertEqual(result.red, ourputR)
        XCTAssertEqual(result.green, ourputG)
        XCTAssertEqual(result.blue, ourputB)
        XCTAssertEqual(result.alpha, ourputA)
    }
    
    func testDarken() {
        let inputR: CGFloat = 0.5
        let inputG: CGFloat = 0.5
        let inputB: CGFloat = 0.5
        let inputA: CGFloat = 1
        let value: CGFloat = 0.1

        let ourputR: CGFloat = inputR - value
        let ourputG: CGFloat = inputG - value
        let ourputB: CGFloat = inputB - value
        let ourputA: CGFloat = inputA
        
        let color: NSColor = .init(red: inputR, green: inputG, blue: inputB, alpha: inputA)
        
        let result = color.darken(by: value).rgbaValues
        
        XCTAssertEqual(result.red, ourputR)
        XCTAssertEqual(result.green, ourputG)
        XCTAssertEqual(result.blue, ourputB)
        XCTAssertEqual(result.alpha, ourputA)
    }
}

#endif
