//
//  DispatchSemaphore+WithLock.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 18.09.24.
//

import Dispatch

extension DispatchSemaphore {
    /// Executes a block of code with a lock, similar to `NSLock`.
    ///
    ///     final class Service: @unchecked Sendable {
    ///         private let dispatchSemaphore: DispatchSemaphore = .init(value: 1)
    ///
    ///         private var _value: Int
    ///
    ///         var value: Int {
    ///             @storageRestrictions(initializes: _value)
    ///             init(initialValue) {
    ///                 self._value = initialValue
    ///             }
    ///             get { dispatchSemaphore.withLock { _value } }
    ///             set { dispatchSemaphore.withLock { _value = newValue } }
    ///         }
    ///
    ///         init(value: Int) {
    ///             self.value = value
    ///         }
    ///     }
    ///
    public func withLock<R>(
        _ body: () throws -> R
    ) rethrows -> R {
        wait()
        defer { signal() }
        
        return try body()
    }
}
