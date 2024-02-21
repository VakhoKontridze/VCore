//
//  XCTAssertThrowsErrorInstance.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 07.02.24.
//

import Foundation
import XCTest

// MARK: - XCT Assert Throws Error Instance
func XCTAssertThrowsError<T, E>(
    _ expression: @autoclosure () throws -> T,
    error: E,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) 
    where E: Error
{
    XCTAssertThrowsError(
        try expression(),
        message(),
        file: file,
        line: line,
        { thrownError in
            guard
                let thrownError = thrownError as? E
            else {
                XCTFail(String.combiningDebugItems(
                    "'\(thrownError)' is not of type '\(String(describing: E.self))'",
                    message()
                ))
                return
            }

            XCTAssertEqual(
                thrownError as NSError,
                error as NSError,
                message(),
                file: file,
                line: line
            )
        }
    )
}
