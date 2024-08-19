//
//  XCTAssertEqualColor.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import SwiftUI
import XCTest
import VCore

// MARK: - XCT Assert Equal Color

#if canImport(UIKit)

func XCTAssertEqualColor(
    _ expression1: @autoclosure () -> UIColor,
    _ expression2: @autoclosure () -> UIColor,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) {
    let lhs = expression1().rgbaValues
    let rhs = expression2().rgbaValues

    XCTAssertEqual(lhs.red, rhs.red, message(), file: file, line: line)
    XCTAssertEqual(lhs.green, rhs.green, message(), file: file, line: line)
    XCTAssertEqual(lhs.blue, rhs.blue, message(), file: file, line: line)
    XCTAssertEqual(lhs.alpha, rhs.alpha, message(), file: file, line: line)
}

#elseif canImport(AppKit)

func XCTAssertEqualColor(
    _ expression1: @autoclosure () -> NSColor,
    _ expression2: @autoclosure () -> NSColor,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) {
    let lhs = expression1().rgbaValues
    let rhs = expression2().rgbaValues

    XCTAssertEqual(lhs.red, rhs.red, message(), file: file, line: line)
    XCTAssertEqual(lhs.green, rhs.green, message(), file: file, line: line)
    XCTAssertEqual(lhs.blue, rhs.blue, message(), file: file, line: line)
    XCTAssertEqual(lhs.alpha, rhs.alpha, message(), file: file, line: line)
}

#endif

func XCTAssertEqualColor(
    _ expression1: @autoclosure () -> Color,
    _ expression2: @autoclosure () -> Color,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) {
#if canImport(UIKit)
    XCTAssertEqualColor(
        UIColor(expression1()),
        UIColor(expression2()),
        message(),
        file: file,
        line: line
    )
#elseif canImport(AppKit)
    XCTAssertEqualColor(
        NSColor(expression1()),
        NSColor(expression2()),
        message(),
        file: file,
        line: line
    )
#endif
}
