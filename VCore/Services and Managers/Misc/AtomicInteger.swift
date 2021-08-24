//
//  AtomicInteger.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK:- Atomic Integer
/// Thread-safe, automatically incremented `Int`
///
/// Object contains `shared` instance, but can also be initialized for separate incrementation
public final class AtomicInteger {
    // MARK: Properties
    private let dispatchSemaphore: DispatchSemaphore = .init(value: 1)
    
    private var _value: Int
    
    /// Generates thread-safe, auto-incremented value of `AtomicInteger`
    public var value: Int {
        dispatchSemaphore.wait()
        defer { dispatchSemaphore.signal() }
        
        let value = _value
        _value += 1
        return value
    }
    
    /// Shared instance of `AtomicInteger`
    public static let shared: AtomicInteger = .init()
    
    // MARK: Initializers
    /// Initializes `AtomicInteger` with an initial value. Defaults to `0`.
    public init(initialValue: Int = 0) {
        self._value = initialValue
    }
}
