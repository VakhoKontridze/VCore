//
//  EdgeInsets_TBTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class EdgeInsets_TBTests: XCTestCase {
    // MARK: Initializers
    func testInitValues() {
        let top: CGFloat = 1
        let bottom: CGFloat = 2
        
        let insets: EdgeInsets_TB = .init(
            top: top,
            bottom: bottom
        )
        
        XCTAssertEqual(insets.top, top)
        XCTAssertEqual(insets.bottom, bottom)
    }
    
    func testInitValue() {
        let value: CGFloat = 1
        
        let insets: EdgeInsets_TB = .init(value)
        
        XCTAssertEqual(insets.top, value)
        XCTAssertEqual(insets.bottom, value)
    }
    
    func testInitZero() {
        let insets: EdgeInsets_TB = .init()
        
        XCTAssertEqual(insets.top, 0)
        XCTAssertEqual(insets.bottom, 0)
    }
    
    func testInitZeroFactory() {
        let insets: EdgeInsets_TB = .zero
        
        XCTAssertEqual(insets.top, 0)
        XCTAssertEqual(insets.bottom, 0)
    }
    
    // MARK: Insets
    func testInsetInset() {
        let inputTop: CGFloat = 1
        let inputBottom: CGFloat = 2
        let inset: CGFloat = 10

        let result: EdgeInsets_TB = .init(
            top: inputTop,
            bottom: inputBottom
        ).insetBy(inset: inset)
        
        XCTAssertEqual(result.top, inputTop + inset)
        XCTAssertEqual(result.bottom, inputBottom + inset)
    }

    func testInsetTop() {
        let inputTop: CGFloat = 1
        let inputBottom: CGFloat = 2
        let inset: CGFloat = 10

        let result: EdgeInsets_TB = .init(
            top: inputTop,
            bottom: inputBottom
        ).insetBy(top: inset)
        
        XCTAssertEqual(result.top, inputTop + inset)
        XCTAssertEqual(result.bottom, inputBottom)
    }
    
    func testInsetBottom() {
        let inputTop: CGFloat = 1
        let inputBottom: CGFloat = 2
        let inset: CGFloat = 10

        let result: EdgeInsets_TB = .init(
            top: inputTop,
            bottom: inputBottom
        ).insetBy(bottom: inset)
        
        XCTAssertEqual(result.top, inputTop)
        XCTAssertEqual(result.bottom, inputBottom + inset)
    }
    
    // MARK: Operators
    func testAddition() {
        let input1Top: CGFloat = 1
        let input1Bottom: CGFloat = 2
        
        let input2Top: CGFloat = 5
        let input2Bottom: CGFloat = 6
        
        let result: EdgeInsets_TB =
            .init(
                top: input1Top,
                bottom: input1Bottom
            ) +
            .init(
                top: input2Top,
                bottom: input2Bottom
            )
        
        XCTAssertEqual(result.top, input1Top + input2Top)
        XCTAssertEqual(result.bottom, input1Bottom + input2Bottom)
    }
    
    func testAdditionAssignment() {
        let input1Top: CGFloat = 1
        let input1Bottom: CGFloat = 2
        
        let input2Top: CGFloat = 5
        let input2Bottom: CGFloat = 6
        
        var result: EdgeInsets_TB = .init(
            top: input1Top,
            bottom: input1Bottom
        )
        result += .init(
            top: input2Top,
            bottom: input2Bottom
        )
        
        XCTAssertEqual(result.top, input1Top + input2Top)
        XCTAssertEqual(result.bottom, input1Bottom + input2Bottom)
    }
    
    func testSubtraction() {
        let input1Top: CGFloat = 1
        let input1Bottom: CGFloat = 2
        
        let input2Top: CGFloat = 5
        let input2Bottom: CGFloat = 6
        
        let result: EdgeInsets_TB =
            .init(
                top: input1Top,
                bottom: input1Bottom
            ) -
            .init(
                top: input2Top,
                bottom: input2Bottom
            )
        
        XCTAssertEqual(result.top, input1Top - input2Top)
        XCTAssertEqual(result.bottom, input1Bottom - input2Bottom)
    }
    
    func testSubtractionAssignment() {
        let input1Top: CGFloat = 1
        let input1Bottom: CGFloat = 2
        
        let input2Top: CGFloat = 5
        let input2Bottom: CGFloat = 6
        
        var result: EdgeInsets_TB = .init(
            top: input1Top,
            bottom: input1Bottom
        )
        result -= .init(
            top: input2Top,
            bottom: input2Bottom
        )
        
        XCTAssertEqual(result.top, input1Top - input2Top)
        XCTAssertEqual(result.bottom, input1Bottom - input2Bottom)
    }
}
