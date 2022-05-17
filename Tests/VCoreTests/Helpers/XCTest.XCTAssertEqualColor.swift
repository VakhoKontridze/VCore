//
//  XCTest.XCTAssertEqualColor.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import Foundation
import XCTest

// MARK: - XCTest Assert Equal Color

#if canImport(UIKit)

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

#elseif canImport(AppKit)

extension XCTest {
    func XCTAssertEqualColor(
        _ expression1: @autoclosure () throws -> NSColor,
        _ expression2: @autoclosure () throws -> NSColor,
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

extension NSColor {
    fileprivate var rgbaValues: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (
            red: red,
            green: green,
            blue: blue,
            alpha: alpha
        )
    }
}

#endif
