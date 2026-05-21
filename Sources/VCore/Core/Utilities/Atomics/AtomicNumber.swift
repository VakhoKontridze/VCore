//
//  AtomicNumber.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

/// Thread-safe, automatically incremented `Number`.
///
///     let idGenerator: AtomicNumber<Int> = .init()
///
///     func generateID() async -> Int {
///         await idGenerator.getAndIncrement()
///     }
///
public actor AtomicNumber<Number> where Number: SignedNumeric {
    // MARK: Properties
    private var value: Number

    // MARK: Initializers
    /// Initializes `AtomicNumber` with an initial value.
    public init(value: Number = .zero) { // `zero` used instead of `0` to avoid automatically inferring `Int`
        self.value = value
    }
    
    // MARK: Accessors
    /// Gets current value.
    public func get() -> Number {
        value
    }

    // MARK: Mutators
    /// Modifies current value.
    public func modify(_ modify: (Number) -> Number) {
        value = modify(value)
    }
    
    /// Sets current value to a given value.
    public func set(_ newValue: Number) {
        modify { _ in newValue }
    }

    /// Adds a given value to current value.
    public func add(_ valueToAdd: Number) {
        modify { $0 + valueToAdd }
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
    /// Modifies current value, and returns it.
    public func modifyAndGet(_ modify: (Number) -> Number) -> Number {
        self.modify(modify)
        return value
    }

    /// Sets current value to a given value, and returns it.
    public func setAndGet(_ newValue: Number) -> Number {
        modifyAndGet { _ in newValue }
    }

    /// Adds a given value to current value, and returns it.
    public func addAndGet(_ valueToAdd: Number) -> Number {
        modifyAndGet { $0 + valueToAdd }
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
    /// Returns current value, and modifies it.
    public func getAndModify(_ modify: (Number) -> Number) -> Number {
        let currentValue: Number = value
        self.modify(modify)
        return currentValue
    }

    /// Returns current value, and sets it to a given value.
    public func getAndSet(_ newValue: Number) -> Number {
        getAndModify { _ in newValue }
    }

    /// Returns current value, and adds a given value to it.
    public func getAndAdd(_ valueToAdd: Number) -> Number {
        getAndModify { $0 + valueToAdd }
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
