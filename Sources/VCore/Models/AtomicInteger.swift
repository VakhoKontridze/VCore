//
//  AtomicInteger.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK: - Atomic Integer
/// Thread-safe, automatically incremented `Int`.
///
/// Object contains `shared` instance, but can also be initialized for separate incrementation.
public actor AtomicInteger {
    // MARK: Properties
    private var value: Int
    
    /// Shared instance of `AtomicInteger`.
    public static let shared: AtomicInteger = .init()
    
    // MARK: Initializers
    /// Initializes `AtomicInteger` with an initial value.
    public init(value: Int = 0) {
        self.value = value
    }
    
    // MARK: Get and Set
    /// Gets current value.
    public func get() -> Int {
        value
    }
    
    /// Sets current value to given value.
    public func set(_ newValue: Int) {
        value = newValue
    }
    
    // MARK: Get and Operation
    /// Returns current value, and adds given value.
    public func getAndAdd(_ valueToAdd: Int) -> Int {
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
