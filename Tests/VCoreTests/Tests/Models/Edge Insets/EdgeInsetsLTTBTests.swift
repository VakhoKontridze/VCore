//
//  EdgeInsetsLTTBTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class EdgeInsetsLTTBTests: XCTestCase {
    // MARK: Properties
    func testProperties() {
        let leading: CGFloat = 1
        let trailing: CGFloat = 2
        let top: CGFloat = 3
        let bottom: CGFloat = 4
        
        let insets: EdgeInsets_LTTB = .init(
            leading: leading,
            trailing: trailing,
            top: top,
            bottom: bottom
        )
        
        XCTAssertEqual(insets.horizontal, leading + trailing)
        XCTAssertEqual(insets.vertical, top + bottom)
    }
    
    // MARK: Initializers
    func testInitValues() {
        let leading: CGFloat = 1
        let trailing: CGFloat = 2
        let top: CGFloat = 3
        let bottom: CGFloat = 4
        
        let insets: EdgeInsets_LTTB = .init(
            leading: leading,
            trailing: trailing,
            top: top,
            bottom: bottom
        )
        
        XCTAssertEqual(insets.leading, leading)
        XCTAssertEqual(insets.trailing, trailing)
        XCTAssertEqual(insets.top, top)
        XCTAssertEqual(insets.bottom, bottom)
    }
    
    func testInitHorizontalVertical() {
        let horizontal: CGFloat = 1
        let vertical: CGFloat = 2
        
        let insets: EdgeInsets_LTTB = .init(
            horizontal: horizontal,
            vertical: vertical
        )
        
        XCTAssertEqual(insets.leading, horizontal)
        XCTAssertEqual(insets.trailing, horizontal)
        XCTAssertEqual(insets.top, vertical)
        XCTAssertEqual(insets.bottom, vertical)
    }
    
    func testInitValue() {
        let value: CGFloat = 1
        
        let insets: EdgeInsets_LTTB = .init(value)
        
        XCTAssertEqual(insets.leading, value)
        XCTAssertEqual(insets.trailing, value)
        XCTAssertEqual(insets.top, value)
        XCTAssertEqual(insets.bottom, value)
    }
    
    func testInitZero() {
        let insets: EdgeInsets_LTTB = .init()
        
        XCTAssertEqual(insets.leading, 0)
        XCTAssertEqual(insets.trailing, 0)
        XCTAssertEqual(insets.top, 0)
        XCTAssertEqual(insets.bottom, 0)
    }
    
    func testInitZeroFactory() {
        let insets: EdgeInsets_LTTB = .zero
        
        XCTAssertEqual(insets.leading, 0)
        XCTAssertEqual(insets.trailing, 0)
        XCTAssertEqual(insets.top, 0)
        XCTAssertEqual(insets.bottom, 0)
    }
    
    // MARK: Insets
    func testInsetInset() {
        let inputLeading: CGFloat = 1
        let inputTrailing: CGFloat = 2
        let inputTop: CGFloat = 3
        let inputBottom: CGFloat = 4
        let inset: CGFloat = 10

        let result: EdgeInsets_LTTB = .init(
            leading: inputLeading,
            trailing: inputTrailing,
            top: inputTop,
            bottom: inputBottom
        ).insetBy(inset: inset)
        
        XCTAssertEqual(result.leading, inputLeading + inset)
        XCTAssertEqual(result.trailing, inputTrailing + inset)
        XCTAssertEqual(result.top, inputTop + inset)
        XCTAssertEqual(result.bottom, inputBottom + inset)
    }
    
    func testInsetHorizontalVertical() {
        let inputLeading: CGFloat = 1
        let inputTrailing: CGFloat = 2
        let inputTop: CGFloat = 3
        let inputBottom: CGFloat = 4
        let insetHorizontal: CGFloat = 10
        let insetVertical: CGFloat = 10
        
        let result: EdgeInsets_LTTB = .init(
            leading: inputLeading,
            trailing: inputTrailing,
            top: inputTop,
            bottom: inputBottom
        ).insetBy(
            horizontal: insetHorizontal,
            vertical: insetVertical
        )
        
        XCTAssertEqual(result.leading, inputLeading + insetHorizontal)
        XCTAssertEqual(result.trailing, inputTrailing + insetHorizontal)
        XCTAssertEqual(result.top, inputTop + insetVertical)
        XCTAssertEqual(result.bottom, inputBottom + insetVertical)
    }
    
    func testInsetLeading() {
        let inputLeading: CGFloat = 1
        let inputTrailing: CGFloat = 2
        let inputTop: CGFloat = 3
        let inputBottom: CGFloat = 4
        let inset: CGFloat = 10

        let result: EdgeInsets_LTTB = .init(
            leading: inputLeading,
            trailing: inputTrailing,
            top: inputTop,
            bottom: inputBottom
        ).insetBy(leading: inset)
        
        XCTAssertEqual(result.leading, inputLeading + inset)
        XCTAssertEqual(result.trailing, inputTrailing)
        XCTAssertEqual(result.top, inputTop)
        XCTAssertEqual(result.bottom, inputBottom)
    }
    
    func testInsetTrailing() {
        let inputLeading: CGFloat = 1
        let inputTrailing: CGFloat = 2
        let inputTop: CGFloat = 3
        let inputBottom: CGFloat = 4
        let inset: CGFloat = 10

        let result: EdgeInsets_LTTB = .init(
            leading: inputLeading,
            trailing: inputTrailing,
            top: inputTop,
            bottom: inputBottom
        ).insetBy(trailing: inset)
        
        XCTAssertEqual(result.leading, inputLeading)
        XCTAssertEqual(result.trailing, inputTrailing + inset)
        XCTAssertEqual(result.top, inputTop)
        XCTAssertEqual(result.bottom, inputBottom)
    }
    
    func testInsetTop() {
        let inputLeading: CGFloat = 1
        let inputTrailing: CGFloat = 2
        let inputTop: CGFloat = 3
        let inputBottom: CGFloat = 4
        let inset: CGFloat = 10

        let result: EdgeInsets_LTTB = .init(
            leading: inputLeading,
            trailing: inputTrailing,
            top: inputTop,
            bottom: inputBottom
        ).insetBy(top: inset)
        
        XCTAssertEqual(result.leading, inputLeading)
        XCTAssertEqual(result.trailing, inputTrailing)
        XCTAssertEqual(result.top, inputTop + inset)
        XCTAssertEqual(result.bottom, inputBottom)
    }
    
    func testInsetBottom() {
        let inputLeading: CGFloat = 1
        let inputTrailing: CGFloat = 2
        let inputTop: CGFloat = 3
        let inputBottom: CGFloat = 4
        let inset: CGFloat = 10

        let result: EdgeInsets_LTTB = .init(
            leading: inputLeading,
            trailing: inputTrailing,
            top: inputTop,
            bottom: inputBottom
        ).insetBy(bottom: inset)
        
        XCTAssertEqual(result.leading, inputLeading)
        XCTAssertEqual(result.trailing, inputTrailing)
        XCTAssertEqual(result.top, inputTop)
        XCTAssertEqual(result.bottom, inputBottom + inset)
    }
    
    // MARK: Operators
    func testAddition() {
        let input1Leading: CGFloat = 1
        let input1Trailing: CGFloat = 2
        let input1Top: CGFloat = 3
        let input1Bottom: CGFloat = 4
        
        let input2Leading: CGFloat = 5
        let input2Trailing: CGFloat = 6
        let input2Top: CGFloat = 7
        let input2Bottom: CGFloat = 8
        
        let result: EdgeInsets_LTTB =
            .init(
                leading: input1Leading,
                trailing: input1Trailing,
                top: input1Top,
                bottom: input1Bottom
            ) +
            .init(
                leading: input2Leading,
                trailing: input2Trailing,
                top: input2Top,
                bottom: input2Bottom
            )
        
        XCTAssertEqual(result.leading, input1Leading + input2Leading)
        XCTAssertEqual(result.trailing, input1Trailing + input2Trailing)
        XCTAssertEqual(result.top, input1Top + input2Top)
        XCTAssertEqual(result.bottom, input1Bottom + input2Bottom)
    }
    
    func testAdditionAssignment() {
        let input1Leading: CGFloat = 1
        let input1Trailing: CGFloat = 2
        let input1Top: CGFloat = 3
        let input1Bottom: CGFloat = 4
        
        let input2Leading: CGFloat = 5
        let input2Trailing: CGFloat = 6
        let input2Top: CGFloat = 7
        let input2Bottom: CGFloat = 8
        
        var result: EdgeInsets_LTTB = .init(
            leading: input1Leading,
            trailing: input1Trailing,
            top: input1Top,
            bottom: input1Bottom
        )
        result += .init(
            leading: input2Leading,
            trailing: input2Trailing,
            top: input2Top,
            bottom: input2Bottom
        )
        
        XCTAssertEqual(result.leading, input1Leading + input2Leading)
        XCTAssertEqual(result.trailing, input1Trailing + input2Trailing)
        XCTAssertEqual(result.top, input1Top + input2Top)
        XCTAssertEqual(result.bottom, input1Bottom + input2Bottom)
    }
    
    func testSubtraction() {
        let input1Leading: CGFloat = 1
        let input1Trailing: CGFloat = 2
        let input1Top: CGFloat = 3
        let input1Bottom: CGFloat = 4
        
        let input2Leading: CGFloat = 5
        let input2Trailing: CGFloat = 6
        let input2Top: CGFloat = 7
        let input2Bottom: CGFloat = 8
        
        let result: EdgeInsets_LTTB =
            .init(
                leading: input1Leading,
                trailing: input1Trailing,
                top: input1Top,
                bottom: input1Bottom
            ) -
            .init(
                leading: input2Leading,
                trailing: input2Trailing,
                top: input2Top,
                bottom: input2Bottom
            )
        
        XCTAssertEqual(result.leading, input1Leading - input2Leading)
        XCTAssertEqual(result.trailing, input1Trailing - input2Trailing)
        XCTAssertEqual(result.top, input1Top - input2Top)
        XCTAssertEqual(result.bottom, input1Bottom - input2Bottom)
    }
    
    func testSubtractionAssignment() {
        let input1Leading: CGFloat = 1
        let input1Trailing: CGFloat = 2
        let input1Top: CGFloat = 3
        let input1Bottom: CGFloat = 4
        
        let input2Leading: CGFloat = 5
        let input2Trailing: CGFloat = 6
        let input2Top: CGFloat = 7
        let input2Bottom: CGFloat = 8
        
        var result: EdgeInsets_LTTB = .init(
            leading: input1Leading,
            trailing: input1Trailing,
            top: input1Top,
            bottom: input1Bottom
        )
        result -= .init(
            leading: input2Leading,
            trailing: input2Trailing,
            top: input2Top,
            bottom: input2Bottom
        )
        
        XCTAssertEqual(result.leading, input1Leading - input2Leading)
        XCTAssertEqual(result.trailing, input1Trailing - input2Trailing)
        XCTAssertEqual(result.top, input1Top - input2Top)
        XCTAssertEqual(result.bottom, input1Bottom - input2Bottom)
    }
}
