//
//  ManagedTaskTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/3/26.
//

import Foundation
import Testing
@testable import VCore

// Needs to run on `MainActor` to simulate real-life scenario.
// `Task`s have `try?` to avoid `CancellationError` for testing purposes.

@Suite(
    .serialized
)
struct ManagedTaskTests {
    // MARK: Tests
    @Test
    func testSimpleCall() async throws {
        let store: Store = .init()
        
        let task: Task<Void, any Error> = .init { try await store.fetch(tag: 1) }
        
        try? await task.value

        #expect(store.number == 1)
        #expect(store.error == nil)
    }

    @Test
    func testSequentialCallsRunningIndependently() async throws {
        let store: Store = .init()
        
        let task1: Task<Void, any Error> = .init { try await store.fetch(tag: 1) }
        
        try? await task1.value
        
        #expect(store.number == 1)
        #expect(store.error == nil)
        
        let task2: Task<Void, any Error> = .init { try await store.fetch(tag: 2) }
        
        try? await task2.value
        
        #expect(store.number == 2)
        #expect(store.error == nil)
    }
    
    @Test
    func testConcurrentCallsDeduplicating() async throws {
        let store: Store = .init()
        
        let task1: Task<Void, any Error> = .init { try await store.fetch(tag: 1, delay: .milliseconds(200)) }
        let task2: Task<Void, any Error> = .init { try await store.fetch(tag: 2, delay: .milliseconds(200)) }
        
        _ = try await (task1.value, task2.value)
        
        #expect(store.number == 1)
        #expect(store.error == nil)
    }
    
    @Test
    func testCancel_PrimaryCancels_SecondaryReceivesResult() async throws {
        let store: Store = .init()
        
        let task1: Task<Void, any Error> = .init { try await store.fetch(tag: 1, delay: .milliseconds(200)) }
        let task2: Task<Void, any Error> = .init { try await store.fetch(tag: 2, delay: .milliseconds(200)) }
        
        try? await Task.sleep(for: .milliseconds(50))
        task1.cancel()
        _ = try? await (task1.value, task2.value)
        
        #expect(store.number == 1)
        #expect(store.error == nil)
    }
    
    @Test
    func testCancel_SecondaryCancels_PrimaryReceivesResult() async throws {
        let store: Store = .init()
        
        let task1: Task<Void, any Error> = .init { try await store.fetch(tag: 1, delay: .milliseconds(200)) }
        let task2: Task<Void, any Error> = .init { try await store.fetch(tag: 2, delay: .milliseconds(200)) }
        
        try? await Task.sleep(for: .milliseconds(50))
        task2.cancel()
        _ = try? await (task1.value, task2.value)
        
        #expect(store.number == 1)
        #expect(store.error == nil)
    }

    @Test
    func testStoreCancel_OneWaiter() async throws {
        let store: Store = .init()

        let task: Task<Void, any Error> = .init { try await store.fetch(tag: 1, delay: .milliseconds(200)) }

        try? await Task.sleep(for: .milliseconds(50))
        store.reset()
        try? await task.value
        
        #expect(store.number == nil)
        #expect(store.error == nil)
    }

    @Test
    func testStoreCancel_MultipleWaiters_OnlyOne() async throws {
        let store: Store = .init()

        let task1: Task<Void, any Error> = .init { try await store.fetch(tag: 1, delay: .milliseconds(200)) }
        let task2: Task<Void, any Error> = .init { try await store.fetch(tag: 2, delay: .milliseconds(200)) }

        try? await Task.sleep(for: .milliseconds(50))
        store.reset(forAllWaiters: false, resetState: false)
        _ = try? await (task1.value, task2.value)

        #expect(store.number == 1)
        #expect(store.error == nil)
    }
    
    @Test
    func testStoreCancel_MultipleWaiters_Multiple() async throws {
        let store: Store = .init()

        let task1: Task<Void, any Error> = .init { try await store.fetch(tag: 1, delay: .milliseconds(200)) }
        let task2: Task<Void, any Error> = .init { try await store.fetch(tag: 2, delay: .milliseconds(200)) }

        try? await Task.sleep(for: .milliseconds(50))
        store.reset()
        _ = try? await (task1.value, task2.value)

        #expect(store.number == nil)
        #expect(store.error == nil)
    }
    
    @Test
    func testFetchAfterForceCancel() async throws {
        let store: Store = .init()

        let task1: Task<Void, any Error> = .init { try await store.fetch(tag: 1, delay: .milliseconds(200)) }

        try? await Task.sleep(for: .milliseconds(50))
        store.reset()
        try? await task1.value

        #expect(store.number == nil)
        #expect(store.error == nil)

        let task2: Task<Void, any Error> = .init { try await store.fetch(tag: 2) }
        
        try? await task2.value

        #expect(store.number == 2)
        #expect(store.error == nil)
    }
    
    // MARK: Types
    @Observable
    private final class Store: Observable, Sendable { // `Observable` needs to be declared because of nesting issues
        // MARK: Properties
        @ObservationIgnored private let repository: Repository = .init()
        
        private(set) var number: Int?
        private(set) var error: (any Error)?
        
        // MARK: Fetch
        func fetch(
            tag: Int,
            delay: Duration? = nil
        ) async throws {
            let number: Int = try await repository.fetch(tag: tag, delay: delay)
            try Task.checkCancellation()
            
            self.number = number
        }
        
        func reset(
            forAllWaiters: Bool = true,
            resetState: Bool = true
        ) {
            repository.reset(
                forAllWaiters: forAllWaiters
            )
            
            if resetState {
                number = nil
            }
        }
    }
    
    nonisolated final class Repository: @unchecked Sendable {
        // MARK: Properties
        private var task: ManagedTask<Int> = .init()
        
        // MARK: Fetch
        func fetch(
            tag: Int,
            delay: Duration?
        ) async throws -> Int {
            try await task.run {
                if let delay {
                    try await Task.sleep(for: delay)
                }
                
                return tag
            }
        }
        
        func reset(
            forAllWaiters: Bool
        ) {
            task.reset(
                cancelForAllWaiters: forAllWaiters
            )
        }
    }
}
