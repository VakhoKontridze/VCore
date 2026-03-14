//
//  AtomicNumber.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

/// Thread-safe, automatically incremented `Numeric`.
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
    /// Sets current value to a given value.
    public func set(_ newValue: Number) {
        value = newValue
    }

    /// Adds a given value to current value
    public func add(_ valueToAdd: Number) {
        value += valueToAdd
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
        value = newValue
        return newValue
    }

    /// Adds a given value to current value, and returns it.
    public func addAndGet(_ valueToAdd: Number) -> Number {
        value += valueToAdd
        return value
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
        let currentValue = value
        value = newValue
        return currentValue
    }

    /// Returns current value, and adds a given value to it.
    public func getAndAdd(_ valueToAdd: Number) -> Number {
        let currentValue = value
        value += valueToAdd
        return currentValue
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
