//
//  AtomicInteger.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK:- Atomic Integer
public final class AtomicInteger {
    // MARK: Properties
    private let dispatchSemaphore: DispatchSemaphore = .init(value: 1)
    
    private var _value: Int
    
    public var value: Int {
        dispatchSemaphore.wait()
        defer { dispatchSemaphore.signal() }
        
        let value = _value
        _value += 1
        return value
    }
    
    static let shared: AtomicInteger = .init()
    
    // MARK: Initializers
    public init(initialValue: Int = 0) {
        self._value = initialValue
    }
}
