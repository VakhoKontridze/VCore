//
//  AtomicInteger.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK:- Atomic Integer
/// Thread-safe, automatically incremented `Int`
public final class AtomicInteger {
    // MARK: Properties
    private let dispatchSemaphore: DispatchSemaphore = .init(value: 1)
    
    private var _value: Int
    
    /// Thread-safe,auto-incremented value of `AtomicInteger` object
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
