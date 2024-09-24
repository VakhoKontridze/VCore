//
//  TaskGroupChildTaskValuesTest.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 24.09.24.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class TaskGroupChildTaskValuesTest: XCTestCase {
    // MARK: Test Data
    private struct Item {
        let value: String
    }
    
    // MARK: Tests
    func testTaskGroup() async {
        let urls: [URL] = [
            #url("1"),
            #url("2"),
            #url("3")
        ]
        
        let items: [Item] = await withTaskGroup(of: Item.self, body: { group in
            for url in urls {
                group.addTask(operation: {
                    try? await Task.sleep(seconds: 0.01)
                    
                    return Item(
                        value: url.absoluteString
                    )
                })
            }

            return await group
                .childTaskValues()
                .sorted(by: \.value)
        })
        
        XCTAssertEqual(
            items.map { $0.value },
            ["1", "2", "3"]
        )
    }
    
    func testThrowingTaskGroup() async throws {
        let urls: [URL] = [
            #url("1"),
            #url("2"),
            #url("3")
        ]
        
        let items: [Item] = try await withThrowingTaskGroup(of: Item.self, body: { group in
            for url in urls {
                group.addTask(operation: {
                    try await Task.sleep(seconds: 0.01)
                    
                    return Item(
                        value: url.absoluteString
                    )
                })
            }

            return try await group
                .childTaskValues()
                .sorted(by: \.value)
        })
        
        XCTAssertEqual(
            items.map { $0.value },
            ["1", "2", "3"]
        )
    }
}
