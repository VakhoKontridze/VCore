//
//  LockedAtomicInteger.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.07.23.
//

import Foundation

// MARK: - Atomic Integer (Locked)
/// Thread-safe, automatically incremented `Int`.
///
///     let idGenerator: LockedAtomicInteger = .init()
///
///     func generateID() -> Int {
///         idGenerator.getAndIncrement()
///     }
///
/// For shared instance, refer to `shared`.
public final class LockedAtomicInteger {
    // MARK: Properties
    private let dispatchSemaphore: DispatchSemaphore = .init(value: 1)

    private var value: Int

    /// Shared instance of `AtomicInteger`.
    public static let shared: LockedAtomicInteger = .init()

    // MARK: Initializers
    /// Initializes `AtomicInteger` with an initial value.
    public init(value: Int = 0) {
        self.value = value
    }

    // MARK: Get and Set
    /// Gets current value.
    public func get() -> Int {
        dispatchSemaphore.wait()
        defer { dispatchSemaphore.signal() }

        return value
    }

    /// Sets current value to given value.
    public func set(_ newValue: Int) {
        dispatchSemaphore.wait()
        defer { dispatchSemaphore.signal() }

        value = newValue
    }

    // MARK: Get and Operation
    /// Returns current value, and adds given value.
    public func getAndAdd(_ valueToAdd: Int) -> Int {
        dispatchSemaphore.wait()
        defer { dispatchSemaphore.signal() }

        let currentValue = value
        value += valueToAdd
        return currentValue
    }

    /// Returns current value, and adds `1`.
    public func getAndIncrement() -> Int {
        getAndAdd(1)
    }

    /// Returns current value, and adds `-1`.
    public func getAndDecrement() -> Int {
        getAndAdd(-1)
    }

    // MARK: Operation and Get
    /// Adds given value to current value, and returns it.
    public func addAndGet(_ valueToAdd: Int) -> Int {
        dispatchSemaphore.wait()
        defer { dispatchSemaphore.signal() }
        
        value += valueToAdd
        return value
    }

    /// Adds `1` to current value, and returns it.
    public func incrementAndGet() -> Int {
        addAndGet(1)
    }

    /// Adds `-1` to current value, and returns it.
    public func decrementAndGet() -> Int {
        addAndGet(-1)
    }
}
