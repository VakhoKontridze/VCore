//
//  XCTestCase.AssertInstanceIsDeallocated.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 21.02.24.
//

import Foundation
import XCTest

// MARK: - XC Test + Assert Instance Is Deallocated
extension XCTestCase {
    @MainActor
    func assertInstanceIsDeallocated(
        _ instance: AnyObject,
        _ message: @escaping @autoclosure () -> String = "",
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
