//
//  AtomicContainer.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.08.22.
//

import Foundation

/// Thread-safe container.
///
///     let accountBalance: AtomicContainer<Double> = .init(value: 100)
///
///     func deposit(_ amount: Double) async {
///         await accountBalance.modify { $0 += amount }
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
    public func setValue(to value: Value) {
        self.value = value
    }
    
    /// Modifies wrapped value.
    public func modify(_ transform: (inout Value) -> Void) {
        transform(&value)
    }
}
