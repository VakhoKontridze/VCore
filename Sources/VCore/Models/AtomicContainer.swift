//
//  AtomicContainer.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.08.22.
//

import Foundation

// MARK: - Atomic Container
/// Thread-safe container.
///
///     let accountBalance: AtomicContainer<Double> = .init(value: 100)
///
///     func deposit(_ amount: Double) async {
///         await accountBalance.setValue(to: accountBalance.value + amount)
///     }
///
public actor AtomicContainer<Value> {
    // MARK: Properties
    /// Value.
    public var value: Value
    
    // MARK: Initializers
    /// Initializes `AtomicContainer` with an initial value.
    public init(value: Value) {
        self.value = value
    }
    
    // MARK: Mutators
    /// Sets wrapped value to specified value.
    public func setValue(to value: Value) async {
        self.value = value
    }
}
