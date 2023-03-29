//
//  EdgeInsetsTopBottomTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class EdgeInsetsTopBottomTests: XCTestCase {
    // MARK: Insets
    func testInsetInset() {
        let inputTop: CGFloat = 1
        let inputBottom: CGFloat = 2
        let inset: CGFloat = 10

        let result: EdgeInsets_TopBottom = .init(
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

        let result: EdgeInsets_TopBottom = .init(
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

        let result: EdgeInsets_TopBottom = .init(
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
        
        let result: EdgeInsets_TopBottom =
            EdgeInsets_TopBottom(
                top: input1Top,
                bottom: input1Bottom
            ) +
            EdgeInsets_TopBottom(
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
        
        var result: EdgeInsets_TopBottom = .init(
            top: input1Top,
            bottom: input1Bottom
        )
        result += EdgeInsets_TopBottom(
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
        
        let result: EdgeInsets_TopBottom =
            EdgeInsets_TopBottom(
                top: input1Top,
                bottom: input1Bottom
            ) -
            EdgeInsets_TopBottom(
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
        
        var result: EdgeInsets_TopBottom = .init(
            top: input1Top,
            bottom: input1Bottom
        )
        result -= EdgeInsets_TopBottom(
            top: input2Top,
            bottom: input2Bottom
        )
        
        XCTAssertEqual(result.top, input1Top - input2Top)
        XCTAssertEqual(result.bottom, input1Bottom - input2Bottom)
    }
}
