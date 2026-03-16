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
        let model: Model = .init()
        
        let task: Task<Void, any Error> = .init { try await model.fetch(tag: 1) }
        
        try? await task.value

        #expect(model.number == 1)
        #expect(model.error == nil)
    }

    @Test
    func testSequentialCallsRunningIndependently() async throws {
        let model: Model = .init()
        
        let task1: Task<Void, any Error> = .init { try await model.fetch(tag: 1) }
        
        try? await task1.value
        
        #expect(model.number == 1)
        #expect(model.error == nil)
        
        let task2: Task<Void, any Error> = .init { try await model.fetch(tag: 2) }
        
        try? await task2.value
        
        #expect(model.number == 2)
        #expect(model.error == nil)
    }
    
    @Test
    func testConcurrentCallsDeduplicating() async throws {
        let model: Model = .init()
        
        let task1: Task<Void, any Error> = .init { try await model.fetch(tag: 1, delay: .milliseconds(200)) }
        let task2: Task<Void, any Error> = .init { try await model.fetch(tag: 2, delay: .milliseconds(200)) }
        
        _ = try await (task1.value, task2.value)
        
        #expect(model.number == 1)
        #expect(model.error == nil)
    }
    
    @Test
    func testCancel_PrimaryCancels_SecondaryReceivesResult() async throws {
        let model: Model = .init()
        
        let task1: Task<Void, any Error> = .init { try await model.fetch(tag: 1, delay: .milliseconds(200)) }
        let task2: Task<Void, any Error> = .init { try await model.fetch(tag: 2, delay: .milliseconds(200)) }
        
        try? await Task.sleep(for: .milliseconds(50))
        task1.cancel()
        _ = try? await (task1.value, task2.value)
        
        #expect(model.number == 1)
        #expect(model.error == nil)
    }
    
    @Test
    func testCancel_SecondaryCancels_PrimaryReceivesResult() async throws {
        let model: Model = .init()
        
        let task1: Task<Void, any Error> = .init { try await model.fetch(tag: 1, delay: .milliseconds(200)) }
        let task2: Task<Void, any Error> = .init { try await model.fetch(tag: 2, delay: .milliseconds(200)) }
        
        try? await Task.sleep(for: .milliseconds(50))
        task2.cancel()
        _ = try? await (task1.value, task2.value)
        
        #expect(model.number == 1)
        #expect(model.error == nil)
    }

    @Test
    func testModelCancel_OneWaiter() async throws {
        let model: Model = .init()

        let task: Task<Void, any Error> = .init { try await model.fetch(tag: 1, delay: .milliseconds(200)) }

        try? await Task.sleep(for: .milliseconds(50))
        model.cancel(force: true)
        try? await task.value
        
        #expect(model.number == nil)
        #expect(model.error == nil)
    }

    @Test
    func testModelCancel_MultipleWaiters_OnlyOne() async throws {
        let model: Model = .init()

        let task1: Task<Void, any Error> = .init { try await model.fetch(tag: 1, delay: .milliseconds(200)) }
        let task2: Task<Void, any Error> = .init { try await model.fetch(tag: 2, delay: .milliseconds(200)) }

        try? await Task.sleep(for: .milliseconds(50))
        model.cancel(force: false)
        _ = try? await (task1.value, task2.value)

        #expect(model.number == 1)
        #expect(model.error == nil)
    }
    
    @Test
    func testModelCancel_MultipleWaiters_Multiple() async throws {
        let model: Model = .init()

        let task1: Task<Void, any Error> = .init { try await model.fetch(tag: 1, delay: .milliseconds(200)) }
        let task2: Task<Void, any Error> = .init { try await model.fetch(tag: 2, delay: .milliseconds(200)) }

        try? await Task.sleep(for: .milliseconds(50))
        model.cancel(force: true)
        _ = try? await (task1.value, task2.value)

        #expect(model.number == nil)
        #expect(model.error == nil)
    }
    
    @Test
    func testFetchAfterForceCancel() async throws {
        let model: Model = .init()

        let task1: Task<Void, any Error> = .init { try await model.fetch(tag: 1, delay: .milliseconds(200)) }

        try? await Task.sleep(for: .milliseconds(50))
        model.cancel(force: true)
        try? await task1.value

        #expect(model.number == nil)
        #expect(model.error == nil)

        let task2: Task<Void, any Error> = .init { try await model.fetch(tag: 2) }
        
        try? await task2.value

        #expect(model.number == 2)
        #expect(model.error == nil)
    }
    
    // MARK: Types
    @Observable
    private final class Model: Observable, Sendable { // `Observable` needs to be declared because of nesting issues
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
        
        func cancel(force: Bool) {
            repository.cancel(forAll: force)
            
            if force {
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
        
        func cancel(
            forAll: Bool
        ) {
            task.cancel(forAllWaiters: forAll)
        }
    }
}
