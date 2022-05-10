//
//  EdgeInsets_LTTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class EdgeInsets_LTTests: XCTestCase {
    // MARK: Initializers
    func testInitValues() {
        let leading: CGFloat = 1
        let trailing: CGFloat = 2
        
        let insets: EdgeInsets_LT = .init(
            leading: leading,
            trailing: trailing
        )
        
        XCTAssertEqual(insets.leading, leading)
        XCTAssertEqual(insets.trailing, trailing)
    }
    
    func testInitValue() {
        let value: CGFloat = 1
        
        let insets: EdgeInsets_LT = .init(value)
        
        XCTAssertEqual(insets.leading, value)
        XCTAssertEqual(insets.trailing, value)
    }
    
    func testInitZero() {
        let insets: EdgeInsets_LT = .init()
        
        XCTAssertEqual(insets.leading, 0)
        XCTAssertEqual(insets.trailing, 0)
    }
    
    func testInitZeroFactory() {
        let insets: EdgeInsets_LT = .zero
        
        XCTAssertEqual(insets.leading, 0)
        XCTAssertEqual(insets.trailing, 0)
    }
    
    // MARK: Insets
    func testInsetInset() {
        let inputLeading: CGFloat = 1
        let inputTrailing: CGFloat = 2
        let inset: CGFloat = 10

        let result: EdgeInsets_LT = .init(
            leading: inputLeading,
            trailing: inputTrailing
        ).insetBy(inset: inset)
        
        XCTAssertEqual(result.leading, inputLeading + inset)
        XCTAssertEqual(result.trailing, inputTrailing + inset)
    }

    func testInsetLeading() {
        let inputLeading: CGFloat = 1
        let inputTrailing: CGFloat = 2
        let inset: CGFloat = 10

        let result: EdgeInsets_LT = .init(
            leading: inputLeading,
            trailing: inputTrailing
        ).insetBy(leading: inset)
        
        XCTAssertEqual(result.leading, inputLeading + inset)
        XCTAssertEqual(result.trailing, inputTrailing)
    }
    
    func testInsetTrailing() {
        let inputLeading: CGFloat = 1
        let inputTrailing: CGFloat = 2
        let inset: CGFloat = 10

        let result: EdgeInsets_LT = .init(
            leading: inputLeading,
            trailing: inputTrailing
        ).insetBy(trailing: inset)
        
        XCTAssertEqual(result.leading, inputLeading)
        XCTAssertEqual(result.trailing, inputTrailing + inset)
    }
    
    // MARK: Operators
    func testAddition() {
        let input1Leading: CGFloat = 1
        let input1Trailing: CGFloat = 2
        
        let input2Leading: CGFloat = 5
        let input2Trailing: CGFloat = 6
        
        let result: EdgeInsets_LT =
            .init(
                leading: input1Leading,
                trailing: input1Trailing
            ) +
            .init(
                leading: input2Leading,
                trailing: input2Trailing
            )
        
        XCTAssertEqual(result.leading, input1Leading + input2Leading)
        XCTAssertEqual(result.trailing, input1Trailing + input2Trailing)
    }
    
    func testAdditionAssignment() {
        let input1Leading: CGFloat = 1
        let input1Trailing: CGFloat = 2
        
        let input2Leading: CGFloat = 5
        let input2Trailing: CGFloat = 6
        
        var result: EdgeInsets_LT = .init(
            leading: input1Leading,
            trailing: input1Trailing
        )
        result += .init(
            leading: input2Leading,
            trailing: input2Trailing
        )
        
        XCTAssertEqual(result.leading, input1Leading + input2Leading)
        XCTAssertEqual(result.trailing, input1Trailing + input2Trailing)
    }
    
    func testSubtraction() {
        let input1Leading: CGFloat = 1
        let input1Trailing: CGFloat = 2
        
        let input2Leading: CGFloat = 5
        let input2Trailing: CGFloat = 6
        
        let result: EdgeInsets_LT =
            .init(
                leading: input1Leading,
                trailing: input1Trailing
            ) -
            .init(
                leading: input2Leading,
                trailing: input2Trailing
            )
        
        XCTAssertEqual(result.leading, input1Leading - input2Leading)
        XCTAssertEqual(result.trailing, input1Trailing - input2Trailing)
    }
    
    func testSubtractionAssignment() {
        let input1Leading: CGFloat = 1
        let input1Trailing: CGFloat = 2
        
        let input2Leading: CGFloat = 5
        let input2Trailing: CGFloat = 6
        
        var result: EdgeInsets_LT = .init(
            leading: input1Leading,
            trailing: input1Trailing
        )
        result -= .init(
            leading: input2Leading,
            trailing: input2Trailing
        )
        
        XCTAssertEqual(result.leading, input1Leading - input2Leading)
        XCTAssertEqual(result.trailing, input1Trailing - input2Trailing)
    }
}
