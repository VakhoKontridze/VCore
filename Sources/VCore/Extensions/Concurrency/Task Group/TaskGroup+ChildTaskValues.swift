//
//  TaskGroup+ChildTaskValues.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 24.09.24.
//

import Foundation

// MARK: - Task Group + Child Task Values
extension TaskGroup {
    /// Collects and returns child task values.
    ///
    ///     let items: [Item] = await withTaskGroup(of: Item.self, body: { group in
    ///         for url in urls {
    ///             group.addTask(operation: {
    ///                 ...
    ///             })
    ///         }
    ///
    ///         return await group.childTaskValues()
    ///     })
    ///
    mutating public func childTaskValues(
        isolation: isolated (any Actor)? = #isolation
    ) async -> [ChildTaskResult] {
        var result: [ChildTaskResult] = []
        
        while let element: ChildTaskResult = await next(isolation: isolation) {
            result.append(element)
        }
        
        return result
    }
}

// MARK: - Throwing Task Group + Child Task Values
extension ThrowingTaskGroup {
    /// Collects and returns child task values.
    ///
    ///     let items: [Item] = try await withThrowingTaskGroup(of: Item.self, body: { group in
    ///         for url in urls {
    ///             group.addTask(operation: {
    ///                 ...
    ///             })
    ///         }
    ///
    ///         return try await group.childTaskValues()
    ///     })
    ///
    mutating public func childTaskValues(
        isolation: isolated (any Actor)? = #isolation
    ) async throws -> [ChildTaskResult] {
        var result: [ChildTaskResult] = []
        
        while let element: ChildTaskResult = try await next(isolation: isolation) {
            result.append(element)
        }
        
        return result
    }
}
