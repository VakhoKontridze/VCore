//
//  XCTestCase.AssertInstanceIsDeallocated.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 21.02.24.
//

import Foundation
import XCTest

nonisolated extension XCTestCase {
    func assertInstanceIsDeallocated(
        _ instance: some AnyObject & Sendable,
        _ message: @Sendable @escaping @autoclosure () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(
                instance,
                String.combiningDebugItems(
                    "Memory leak detected",
                    message()
                ),
                file: file,
                line: line
            )
        }
    }
}
