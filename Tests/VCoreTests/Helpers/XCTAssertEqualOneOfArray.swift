//
//  XCTAssertEqualOneOfArray.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.09.23.
//

import Foundation
import XCTest
import VCore

// MARK: - XCT Assert Equal One of Array
func XCTAssertEqual<T>(
    _ expression1: @autoclosure () throws -> T,
    oneOf expression2: @autoclosure () throws -> [T],
    _ message: @autoclosure () -> String = ""
)
    where T: Equatable
{
    let expression1Value: T
    do {
        expression1Value = try expression1()

    } catch {
        XCTFail(
            String.combiningDebugItems(
                "Failed to retrieve 'expression1'",
                error,
                message()
            )
        )

        return
    }

    let expression2Values: [T]
    do {
        expression2Values = try expression2()

    } catch {
        XCTFail(
            String.combiningDebugItems(
                "Failed to retrieve 'expression2'",
                error,
                message()
            )
        )

        return
    }

    for expression2Value in expression2Values {
        if expression1Value == expression2Value {
            return
        }
    }

    XCTFail(
        String.combiningDebugItems(
            "Failed to match '\(expression1Value)' with any values from '\(expression2Values)'",
            message()
        )
    )
}
