//
//  XCTest.XCTAssertEqualValuesFrom.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.09.23.
//

import Foundation
import XCTest

// MARK: - XCTest Assert Equal Values From
func XCTAssertEqual<T>(
    _ expression1: @autoclosure () throws -> T,
    valuesFrom expression2s: @autoclosure () throws -> [T],
    _ message: @autoclosure () -> String = ""
)
    where T: Equatable
{
    let expression1 = try! expression1()

    for expression2 in try! expression2s() {
        if expression1 == expression2 {
            return
        }
    }

    XCTFail(message())
}
