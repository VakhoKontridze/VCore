//
//  XCTest.XCTAssertEqualColor.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import Foundation
import XCTest

// MARK: - XCTest Assert Equal Color
extension XCTest {
    func XCTAssertEqualColor(
        _ expression1: @autoclosure () throws -> UIColor,
        _ expression2: @autoclosure () throws -> UIColor,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let lhs = try! expression1().rgbaValues // fatalError
        let rhs = try! expression2().rgbaValues // fatalError
        
        XCTAssertEqual(lhs.red, rhs.red, message(), file: file, line: line)
        XCTAssertEqual(lhs.green, rhs.green, message(), file: file, line: line)
        XCTAssertEqual(lhs.blue, rhs.blue, message(), file: file, line: line)
        XCTAssertEqual(lhs.alpha, rhs.alpha, message(), file: file, line: line)
    }
}
