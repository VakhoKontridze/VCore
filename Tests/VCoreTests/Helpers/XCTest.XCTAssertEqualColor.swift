//
//  XCTest.XCTAssertEqualColor.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import SwiftUI
import XCTest
import VCore

// MARK: - XCTest Assert Equal Color

#if canImport(UIKit)

func XCTAssertEqualColor(
    _ expression1: @autoclosure () throws -> UIColor,
    _ expression2: @autoclosure () throws -> UIColor,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) {
    let lhs = try! expression1().rgbaValues // Force-unwrap
    let rhs = try! expression2().rgbaValues // Force-unwrap

    XCTAssertEqual(lhs.red, rhs.red, message(), file: file, line: line)
    XCTAssertEqual(lhs.green, rhs.green, message(), file: file, line: line)
    XCTAssertEqual(lhs.blue, rhs.blue, message(), file: file, line: line)
    XCTAssertEqual(lhs.alpha, rhs.alpha, message(), file: file, line: line)
}

#elseif canImport(AppKit)

func XCTAssertEqualColor(
    _ expression1: @autoclosure () throws -> NSColor,
    _ expression2: @autoclosure () throws -> NSColor,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) {
    let lhs = try! expression1().rgbaValues // Force-unwrap
    let rhs = try! expression2().rgbaValues // Force-unwrap

    XCTAssertEqual(lhs.red, rhs.red, message(), file: file, line: line)
    XCTAssertEqual(lhs.green, rhs.green, message(), file: file, line: line)
    XCTAssertEqual(lhs.blue, rhs.blue, message(), file: file, line: line)
    XCTAssertEqual(lhs.alpha, rhs.alpha, message(), file: file, line: line)
}

#endif

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
func XCTAssertEqualColor(
    _ expression1: @autoclosure () throws -> Color,
    _ expression2: @autoclosure () throws -> Color,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) {
#if canImport(UIKit)
    return XCTAssertEqualColor(
        UIColor(try! expression1()), // Force-unwrap
        UIColor(try! expression2()), // Force-unwrap
        message(),
        file: file,
        line: line
    )
#elseif canImport(AppKit)
    return XCTAssertEqualColor(
        NSColor(try! expression1()), // Force-unwrap
        NSColor(try! expression2()), // Force-unwrap
        message(),
        file: file,
        line: line
    )
#endif
}
