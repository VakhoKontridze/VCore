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
        let store: Store = .init()

        let task: Task<Void, any Error> = .init { try await store.fetch(id: 1, tag: 1) }

        try? await task.value

        #expect(store.numbers[1] == 1)
        #expect(store.error == nil)
    }

    @Test
    func testSequentialCallsRunningIndependently() async throws {
        let store: Store = .init()

        let task1: Task<Void, any Error> = .init { try await store.fetch(id: 1, tag: 1) }

        try? await task1.value

        #expect(store.numbers[1] == 1)
        #expect(store.error == nil)

        let task2: Task<Void, any Error> = .init { try await store.fetch(id: 1, tag: 2) }

        try? await task2.value

        #expect(store.numbers[1] == 2)
        #expect(store.error == nil)
    }

    @Test
    func testConcurrentCallsSameKey_Deduplicate() async throws {
        let store: Store = .init()

        let task1: Task<Void, any Error> = .init { try await store.fetch(id: 1, tag: 1, delay: .milliseconds(200)) }
        let task2: Task<Void, any Error> = .init { try await store.fetch(id: 1, tag: 2, delay: .milliseconds(200)) }

        _ = try await (task1.value, task2.value)

        #expect(store.numbers[1] == 1)
        #expect(store.error == nil)
    }

    @Test
    func testConcurrentCallsDifferentKeys_RunIndependently() async throws {
        let store: Store = .init()

        let task1: Task<Void, any Error> = .init { try await store.fetch(id: 1, tag: 1, delay: .milliseconds(200)) }
        let task2: Task<Void, any Error> = .init { try await store.fetch(id: 2, tag: 2, delay: .milliseconds(200)) }

        _ = try await (task1.value, task2.value)

        #expect(store.numbers[1] == 1)
        #expect(store.numbers[2] == 2)
        #expect(store.error == nil)
    }

    @Test
    func testCancel_PrimaryCancels_SecondaryReceivesResult() async throws {
        let store: Store = .init()

        let task1: Task<Void, any Error> = .init { try await store.fetch(id: 1, tag: 1, delay: .milliseconds(200)) }
        let task2: Task<Void, any Error> = .init { try await store.fetch(id: 1, tag: 2, delay: .milliseconds(200)) }

        try? await Task.sleep(for: .milliseconds(50))
        task1.cancel()
        _ = try? await (task1.value, task2.value)

        #expect(store.numbers[1] == 1)
        #expect(store.error == nil)
    }

    @Test
    func testCancel_SecondaryCancels_PrimaryReceivesResult() async throws {
        let store: Store = .init()

        let task1: Task<Void, any Error> = .init { try await store.fetch(id: 1, tag: 1, delay: .milliseconds(200)) }
        let task2: Task<Void, any Error> = .init { try await store.fetch(id: 1, tag: 2, delay: .milliseconds(200)) }

        try? await Task.sleep(for: .milliseconds(50))
        task2.cancel()
        _ = try? await (task1.value, task2.value)

        #expect(store.numbers[1] == 1)
        #expect(store.error == nil)
    }

    @Test
    func testStoreCancel_OneWaiter() async throws {
        let store: Store = .init()

        let task: Task<Void, any Error> = .init { try await store.fetch(id: 1, tag: 1, delay: .milliseconds(200)) }

        try? await Task.sleep(for: .milliseconds(50))
        store.reset(id: 1)
        try? await task.value

        #expect(store.numbers[1] == nil)
        #expect(store.error == nil)
    }

    @Test
    func testStoreCancel_MultipleWaiters_OnlyOne() async throws {
        let store: Store = .init()

        let task1: Task<Void, any Error> = .init { try await store.fetch(id: 1, tag: 1, delay: .milliseconds(200)) }
        let task2: Task<Void, any Error> = .init { try await store.fetch(id: 1, tag: 2, delay: .milliseconds(200)) }

        try? await Task.sleep(for: .milliseconds(50))
        store.reset(id: 1, forAllWaiters: false, resetState: false)
        _ = try? await (task1.value, task2.value)

        #expect(store.numbers[1] == 1)
        #expect(store.error == nil)
    }

    @Test
    func testStoreCancel_MultipleWaiters_Multiple() async throws {
        let store: Store = .init()

        let task1: Task<Void, any Error> = .init { try await store.fetch(id: 1, tag: 1, delay: .milliseconds(200)) }
        let task2: Task<Void, any Error> = .init { try await store.fetch(id: 1, tag: 2, delay: .milliseconds(200)) }

        try? await Task.sleep(for: .milliseconds(50))
        store.reset(id: 1)
        _ = try? await (task1.value, task2.value)

        #expect(store.numbers[1] == nil)
        #expect(store.error == nil)
    }

    // Not testable reliable without testing hooks, so the test is skipped
    //@Test
    //func testStoreCancelAll_OnlyOne() async throws {}

    @Test
    func testStoreCancelAll_Multiple() async throws {
        let store: Store = .init()

        let task1: Task<Void, any Error> = .init { try await store.fetch(id: 1, tag: 1, delay: .milliseconds(200)) }
        let task2: Task<Void, any Error> = .init { try await store.fetch(id: 2, tag: 2, delay: .milliseconds(200)) }

        try? await Task.sleep(for: .milliseconds(50))
        store.resetAll()
        _ = try? await (task1.value, task2.value)

        #expect(store.numbers[1] == nil)
        #expect(store.numbers[2] == nil)
        #expect(store.error == nil)
    }

    @Test
    func testFetchAfterForceCancel() async throws {
        let store: Store = .init()

        let task1: Task<Void, any Error> = .init { try await store.fetch(id: 1, tag: 1, delay: .milliseconds(200)) }

        try? await Task.sleep(for: .milliseconds(50))
        store.reset(id: 1)
        try? await task1.value

        #expect(store.numbers[1] == nil)
        #expect(store.error == nil)

        let task2: Task<Void, any Error> = .init { try await store.fetch(id: 1, tag: 2) }

        try? await task2.value

        #expect(store.numbers[1] == 2)
        #expect(store.error == nil)
    }

    // MARK: Types
    @Observable
    private final class Store: Observable, Sendable { // `Observable` needs to be declared because of nesting issues
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

        func reset(
            id: Int,
            forAllWaiters: Bool = true,
            resetState: Bool = true
        ) {
            repository.cancel(
                id: id,
                forAllWaiters: forAllWaiters
            )

            if resetState {
                numbers[id] = nil
            }
        }

        func resetAll(
            forAllWaiters: Bool = true,
            resetState: Bool = true
        ) {
            repository.cancelAll(
                forAllWaiters: forAllWaiters
            )

            if resetState {
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

        func cancel(
            id: Int,
            forAllWaiters: Bool = true
        ) {
            task.reset(
                key: id,
                cancelForAllWaiters: forAllWaiters
            )
        }

        func cancelAll(
            forAllWaiters: Bool
        ) {
            task.resetAll(
                cancelForAllWaiters: forAllWaiters
            )
        }
    }
}
