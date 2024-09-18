//
//  LockedAtomicNumber.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.07.23.
//

import Foundation

// MARK: - Atomic Number (Locked)
/// Thread-safe, automatically incremented `Number`.
///
///     let idGenerator: LockedAtomicNumber<Int> = .init()
///
///     func generateID() -> Int {
///         idGenerator.getAndIncrement()
///     }
///
public final class LockedAtomicNumber<Number>: @unchecked Sendable
    where Number: Numeric
{
    // MARK: Proeprties - Value
    private var value: Number
    
    // MARK: Properties - Semaphore
    private let dispatchSemaphore: DispatchSemaphore = .init(value: 1)

    // MARK: Initializers
    /// Initializes `LockedAtomicNumber` with an initial value.
    public init(value: Number = .zero) { // `zero` used instead of `0` to avoid automatically inferring `Int`
        self.value = value
    }

    // MARK: Accessors
    /// Gets current value.
    public func get() -> Number {
        dispatchSemaphore.withLock({
            value
        })
    }

    // MARK: Mutators
    /// Sets current value to a given value.
    public func set(_ newValue: Number) {
        dispatchSemaphore.withLock({
            value = newValue
        })
    }

    /// Adds a given value to current value
    public func add(_ valueToAdd: Number) {
        dispatchSemaphore.withLock({
            value += valueToAdd
        })
    }

    /// Adds `1` to current value.
    public func increment() {
        add(1)
    }

    /// Adds `-1` to current value.
    public func decrement() {
        add(-1)
    }

    // MARK: Get and Pre-Mutators
    /// Sets current value to a given value, and returns it.
    public func setAndGet(_ newValue: Number) -> Number {
        dispatchSemaphore.withLock({
            value = newValue
            return newValue
        })
    }

    /// Adds a given value to current value, and returns it.
    public func addAndGet(_ valueToAdd: Number) -> Number {
        dispatchSemaphore.withLock({
            value += valueToAdd
            return value
        })
    }

    /// Adds `1` to current value, and returns it.
    public func incrementAndGet() -> Number {
        addAndGet(1)
    }

    /// Adds `-1` to current value, and returns it.
    public func decrementAndGet() -> Number {
        addAndGet(-1)
    }

    // MARK: Get and Post-Mutators
    /// Returns current value, and sets it to a given value.
    public func getAndSet(_ newValue: Number) -> Number {
        dispatchSemaphore.withLock({
            let currentValue = value
            value = newValue
            return currentValue
        })
    }

    /// Returns current value, and adds a given value to it.
    public func getAndAdd(_ valueToAdd: Number) -> Number {
        dispatchSemaphore.withLock({
            let currentValue = value
            value += valueToAdd
            return currentValue
        })
    }

    /// Returns current value, and adds `1` to it.
    public func getAndIncrement() -> Number {
        getAndAdd(1)
    }

    /// Returns current value, and adds `-1` to it.
    public func getAndDecrement() -> Number {
        getAndAdd(-1)
    }
}

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
public typealias LockedAtomicInteger = LockedAtomicNumber<Int>

extension LockedAtomicInteger {
    /// Shared instance of `LockedAtomicNumber`.
    public static let shared: LockedAtomicNumber = .init()
}
