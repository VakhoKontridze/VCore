//
//  TaskGroupChildTaskValuesTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 24.09.24.
//

import Foundation
import Testing
@testable import VCore

@Suite
struct TaskGroupChildTaskValuesTests {
    // MARK: Tests
    @Test
    func testTaskGroup() async {
        let urls: [URL] = [
            #url("1"),
            #url("2"),
            #url("3")
        ]
        
        let items: [Item] = await withTaskGroup { group in
            for url in urls {
                group.addTask {
                    try? await Task.sleep(for: .seconds(0.01))
                    
                    return Item(
                        value: url.absoluteString
                    )
                }
            }

            return await group
                .childTaskValues()
                .sorted(by: \.value)
        }
        
        #expect(
            items.map { $0.value } ==
            ["1", "2", "3"]
        )
    }
    
    @Test
    func testThrowingTaskGroup() async throws {
        let urls: [URL] = [
            #url("1"),
            #url("2"),
            #url("3")
        ]
        
        let items: [Item] = try await withThrowingTaskGroup { group in
            for url in urls {
                group.addTask {
                    try? await Task.sleep(for: .seconds(0.01))
                    
                    return Item(
                        value: url.absoluteString
                    )
                }
            }

            return try await group
                .childTaskValues()
                .sorted(by: \.value)
        }
        
        #expect(
            items.map { $0.value } ==
            ["1", "2", "3"]
        )
    }
    
    // MARK: Types
    private struct Item {
        let value: String
    }
}
