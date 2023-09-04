//
//  XCTAssertEqualArray.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.09.23.
//

import Foundation
import XCTest

// MARK: - XCTest Assert Equal Array
func XCTAssertEqual<T>(
    _ expression1: @autoclosure () throws -> T,
    oneOf expression2s: @autoclosure () throws -> [T],
    _ message: @autoclosure () -> String = ""
)
    where T: Equatable
{
    let expression1: T = try! expression1() // Force-unwrap

    for expression2 in try! expression2s() { // Force-unwrap
        if expression1 == expression2 {
            return
        }
    }

    XCTFail(message())
}
