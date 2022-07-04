//
//  EdgeInsetsHVTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class EdgeInsetsHVTests: XCTestCase {
    // MARK: Insets
    func testInsetInset() {
        let inputHorizontal: CGFloat = 1
        let inputVertical: CGFloat = 2
        let inset: CGFloat = 10

        let result: EdgeInsets_HorizontalVertical = .init(
            horizontal: inputHorizontal,
            vertical: inputVertical
        ).insetBy(inset: inset)
        
        XCTAssertEqual(result.horizontal, inputHorizontal + inset)
        XCTAssertEqual(result.vertical, inputVertical + inset)
    }

    func testInsetHorizontal() {
        let inputHorizontal: CGFloat = 1
        let inputVertical: CGFloat = 2
        let inset: CGFloat = 10

        let result: EdgeInsets_HorizontalVertical = .init(
            horizontal: inputHorizontal,
            vertical: inputVertical
        ).insetBy(horizontal: inset)
        
        XCTAssertEqual(result.horizontal, inputHorizontal + inset)
        XCTAssertEqual(result.vertical, inputVertical)
    }
    
    func testInsetVertical() {
        let inputHorizontal: CGFloat = 1
        let inputVertical: CGFloat = 2
        let inset: CGFloat = 10

        let result: EdgeInsets_HorizontalVertical = .init(
            horizontal: inputHorizontal,
            vertical: inputVertical
        ).insetBy(vertical: inset)
        
        XCTAssertEqual(result.horizontal, inputHorizontal)
        XCTAssertEqual(result.vertical, inputVertical + inset)
    }
    
    // MARK: Operators
    func testAddition() {
        let input1Horizontal: CGFloat = 1
        let input1Vertical: CGFloat = 2
        
        let input2Horizontal: CGFloat = 5
        let input2Vertical: CGFloat = 6
        
        let result: EdgeInsets_HorizontalVertical =
            .init(
                horizontal: input1Horizontal,
                vertical: input1Vertical
            ) +
            .init(
                horizontal: input2Horizontal,
                vertical: input2Vertical
            )
        
        XCTAssertEqual(result.horizontal, input1Horizontal + input2Horizontal)
        XCTAssertEqual(result.vertical, input1Vertical + input2Vertical)
    }
    
    func testAdditionAssignment() {
        let input1Horizontal: CGFloat = 1
        let input1Vertical: CGFloat = 2
        
        let input2Horizontal: CGFloat = 5
        let input2Vertical: CGFloat = 6
        
        var result: EdgeInsets_HorizontalVertical = .init(
            horizontal: input1Horizontal,
            vertical: input1Vertical
        )
        result += .init(
            horizontal: input2Horizontal,
            vertical: input2Vertical
        )
        
        XCTAssertEqual(result.horizontal, input1Horizontal + input2Horizontal)
        XCTAssertEqual(result.vertical, input1Vertical + input2Vertical)
    }
    
    func testSubtraction() {
        let input1Horizontal: CGFloat = 1
        let input1Vertical: CGFloat = 2
        
        let input2Horizontal: CGFloat = 5
        let input2Vertical: CGFloat = 6
        
        let result: EdgeInsets_HorizontalVertical =
            .init(
                horizontal: input1Horizontal,
                vertical: input1Vertical
            ) -
            .init(
                horizontal: input2Horizontal,
                vertical: input2Vertical
            )
        
        XCTAssertEqual(result.horizontal, input1Horizontal - input2Horizontal)
        XCTAssertEqual(result.vertical, input1Vertical - input2Vertical)
    }
    
    func testSubtractionAssignment() {
        let input1Horizontal: CGFloat = 1
        let input1Vertical: CGFloat = 2
        
        let input2Horizontal: CGFloat = 5
        let input2Vertical: CGFloat = 6
        
        var result: EdgeInsets_HorizontalVertical = .init(
            horizontal: input1Horizontal,
            vertical: input1Vertical
        )
        result -= .init(
            horizontal: input2Horizontal,
            vertical: input2Vertical
        )
        
        XCTAssertEqual(result.horizontal, input1Horizontal - input2Horizontal)
        XCTAssertEqual(result.vertical, input1Vertical - input2Vertical)
    }
}
