//
//  KeyedManagedTaskTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 17/3/26.
//

import Foundation
import Testing
@testable import VCore

// Needs to run on `MainActor` to simulate real-life scenario.
// `Task`s have `try?` to avoid `CancellationError` for testing purposes.

@Suite(
    .serialized
)
struct KeyedManagedTaskTests {
    // MARK: Tests
    @Test
    func testSimpleCall() async throws {
        let model: Model = .init()

        let task: Task<Void, any Error> = .init { try await model.fetch(id: 1, tag: 1) }

        try? await task.value

        #expect(model.numbers[1] == 1)
        #expect(model.error == nil)
    }

    @Test
    func testSequentialCallsRunningIndependently() async throws {
        let model: Model = .init()

        let task1: Task<Void, any Error> = .init { try await model.fetch(id: 1, tag: 1) }

        try? await task1.value

        #expect(model.numbers[1] == 1)
        #expect(model.error == nil)

        let task2: Task<Void, any Error> = .init { try await model.fetch(id: 1, tag: 2) }

        try? await task2.value

        #expect(model.numbers[1] == 2)
        #expect(model.error == nil)
    }

    @Test
    func testConcurrentCallsSameKey_Deduplicate() async throws {
        let model: Model = .init()

        let task1: Task<Void, any Error> = .init { try await model.fetch(id: 1, tag: 1, delay: .milliseconds(200)) }
        let task2: Task<Void, any Error> = .init { try await model.fetch(id: 1, tag: 2, delay: .milliseconds(200)) }

        _ = try await (task1.value, task2.value)

        #expect(model.numbers[1] == 1)
        #expect(model.error == nil)
    }

    @Test
    func testConcurrentCallsDifferentKeys_RunIndependently() async throws {
        let model: Model = .init()

        let task1: Task<Void, any Error> = .init { try await model.fetch(id: 1, tag: 1, delay: .milliseconds(200)) }
        let task2: Task<Void, any Error> = .init { try await model.fetch(id: 2, tag: 2, delay: .milliseconds(200)) }

        _ = try await (task1.value, task2.value)

        #expect(model.numbers[1] == 1)
        #expect(model.numbers[2] == 2)
        #expect(model.error == nil)
    }

    @Test
    func testCancel_PrimaryCancels_SecondaryReceivesResult() async throws {
        let model: Model = .init()

        let task1: Task<Void, any Error> = .init { try await model.fetch(id: 1, tag: 1, delay: .milliseconds(200)) }
        let task2: Task<Void, any Error> = .init { try await model.fetch(id: 1, tag: 2, delay: .milliseconds(200)) }

        try? await Task.sleep(for: .milliseconds(50))
        task1.cancel()
        _ = try? await (task1.value, task2.value)

        #expect(model.numbers[1] == 1)
        #expect(model.error == nil)
    }

    @Test
    func testCancel_SecondaryCancels_PrimaryReceivesResult() async throws {
        let model: Model = .init()

        let task1: Task<Void, any Error> = .init { try await model.fetch(id: 1, tag: 1, delay: .milliseconds(200)) }
        let task2: Task<Void, any Error> = .init { try await model.fetch(id: 1, tag: 2, delay: .milliseconds(200)) }

        try? await Task.sleep(for: .milliseconds(50))
        task2.cancel()
        _ = try? await (task1.value, task2.value)

        #expect(model.numbers[1] == 1)
        #expect(model.error == nil)
    }

    @Test
    func testModelCancel_OneWaiter() async throws {
        let model: Model = .init()

        let task: Task<Void, any Error> = .init { try await model.fetch(id: 1, tag: 1, delay: .milliseconds(200)) }

        try? await Task.sleep(for: .milliseconds(50))
        model.cancel(id: 1, force: true)
        try? await task.value

        #expect(model.numbers[1] == nil)
        #expect(model.error == nil)
    }

    @Test
    func testModelCancel_MultipleWaiters_OnlyOne() async throws {
        let model: Model = .init()

        let task1: Task<Void, any Error> = .init { try await model.fetch(id: 1, tag: 1, delay: .milliseconds(200)) }
        let task2: Task<Void, any Error> = .init { try await model.fetch(id: 1, tag: 2, delay: .milliseconds(200)) }

        try? await Task.sleep(for: .milliseconds(50))
        model.cancel(id: 1, force: false)
        _ = try? await (task1.value, task2.value)

        #expect(model.numbers[1] == 1)
        #expect(model.error == nil)
    }

    @Test
    func testModelCancel_MultipleWaiters_Multiple() async throws {
        let model: Model = .init()

        let task1: Task<Void, any Error> = .init { try await model.fetch(id: 1, tag: 1, delay: .milliseconds(200)) }
        let task2: Task<Void, any Error> = .init { try await model.fetch(id: 1, tag: 2, delay: .milliseconds(200)) }

        try? await Task.sleep(for: .milliseconds(50))
        model.cancel(id: 1, force: true)
        _ = try? await (task1.value, task2.value)

        #expect(model.numbers[1] == nil)
        #expect(model.error == nil)
    }

    // Not testable reliable without testing hooks, so the test is skipped
    //@Test
    //func testModelCancelAll_OnlyOne() async throws {}

    @Test
    func testModelCancelAll_Multiple() async throws {
        let model: Model = .init()

        let task1: Task<Void, any Error> = .init { try await model.fetch(id: 1, tag: 1, delay: .milliseconds(200)) }
        let task2: Task<Void, any Error> = .init { try await model.fetch(id: 2, tag: 2, delay: .milliseconds(200)) }

        try? await Task.sleep(for: .milliseconds(50))
        model.cancelAll(force: true)
        _ = try? await (task1.value, task2.value)

        #expect(model.numbers[1] == nil)
        #expect(model.numbers[2] == nil)
        #expect(model.error == nil)
    }

    @Test
    func testFetchAfterForceCancel() async throws {
        let model: Model = .init()

        let task1: Task<Void, any Error> = .init { try await model.fetch(id: 1, tag: 1, delay: .milliseconds(200)) }

        try? await Task.sleep(for: .milliseconds(50))
        model.cancel(id: 1, force: true)
        try? await task1.value

        #expect(model.numbers[1] == nil)
        #expect(model.error == nil)

        let task2: Task<Void, any Error> = .init { try await model.fetch(id: 1, tag: 2) }

        try? await task2.value

        #expect(model.numbers[1] == 2)
        #expect(model.error == nil)
    }

    // MARK: Types
    @Observable
    private final class Model: Observable, Sendable { // `Observable` needs to be declared because of nesting issues
        // MARK: Properties
        @ObservationIgnored private let repository: Repository = .init()

        private(set) var numbers: [Int: Int] = [:]
        private(set) var error: (any Error)?

        // MARK: Fetch
        func fetch(
            id: Int,
            tag: Int,
            delay: Duration? = nil
        ) async throws {
            let number: Int = try await repository.fetch(id: id, tag: tag, delay: delay)
            try Task.checkCancellation()

            numbers[id] = number
        }

        func cancel(id: Int, force: Bool) {
            repository.cancel(id: id, forAll: force)

            if force {
                numbers[id] = nil
            }
        }

        func cancelAll(force: Bool) {
            repository.cancelAll(forAll: force)

            if force {
                numbers = [:]
            }
        }
    }

    nonisolated final class Repository: @unchecked Sendable {
        // MARK: Properties
        private var task: KeyedManagedTask<Int, Int> = .init()

        // MARK: Fetch
        func fetch(
            id: Int,
            tag: Int,
            delay: Duration?
        ) async throws -> Int {
            try await task.run(key: id) {
                if let delay {
                    try await Task.sleep(for: delay)
                }

                return tag
            }
        }

        func cancel(id: Int, forAll: Bool) {
            task.cancel(key: id, forAllWaiters: forAll)
        }

        func cancelAll(forAll: Bool) {
            task.cancelAll(forAllWaiters: forAll)
        }
    }
}
