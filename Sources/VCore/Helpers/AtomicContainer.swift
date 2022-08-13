//
//  AtomicContainer.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.08.22.
//

import Foundation

// MARK: - Atomic Container
/// Thread-safe container.
public actor AtomicContainer<Value> {
    // MARK: Properties
    /// Value.
    public var value: Value
    
    // MARK: Initializers
    /// Initializes `AtomicContainer` with an initial value.
    public init(value: Value) {
        self.value = value
    }
}
