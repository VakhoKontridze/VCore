//
//  EdgeInsetsLeadingTrailingTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class EdgeInsetsLeadingTrailingTests: XCTestCase {
    // MARK: Insets
    func testInsetInset() {
        let inputLeading: CGFloat = 1
        let inputTrailing: CGFloat = 2
        let inset: CGFloat = 10
        
        let result: EdgeInsets_LeadingTrailing = .init(
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
        
        let result: EdgeInsets_LeadingTrailing = .init(
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
        
        let result: EdgeInsets_LeadingTrailing = .init(
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
        
        let result: EdgeInsets_LeadingTrailing =
            EdgeInsets_LeadingTrailing(
                leading: input1Leading,
                trailing: input1Trailing
            ) +
            EdgeInsets_LeadingTrailing(
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
        
        var result: EdgeInsets_LeadingTrailing = .init(
            leading: input1Leading,
            trailing: input1Trailing
        )
        result += EdgeInsets_LeadingTrailing(
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
        
        let result: EdgeInsets_LeadingTrailing =
            EdgeInsets_LeadingTrailing(
                leading: input1Leading,
                trailing: input1Trailing
            ) -
            EdgeInsets_LeadingTrailing(
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
        
        var result: EdgeInsets_LeadingTrailing = .init(
            leading: input1Leading,
            trailing: input1Trailing
        )
        result -= EdgeInsets_LeadingTrailing(
            leading: input2Leading,
            trailing: input2Trailing
        )
        
        XCTAssertEqual(result.leading, input1Leading - input2Leading)
        XCTAssertEqual(result.trailing, input1Trailing - input2Trailing)
    }
}
