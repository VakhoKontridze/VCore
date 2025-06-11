//
//  DispatchSemaphore+WithLock.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 18.09.24.
//

import Dispatch

// MARK: - Dispatch Semaphore + With Lock
extension DispatchSemaphore {
    /// Executes a block of code with a lock, similar to `NSLock`.
    ///
    ///     final class SomeClass: @unchecked Sendable {
    ///         private let dispatchSemaphore: DispatchSemaphore = .init(value: 1)
    ///
    ///         private var _value: Int
    ///
    ///         var value: Int {
    ///             @storageRestrictions(initializes: _configuration)
    ///             init(initialValue) {
    ///                 self._configuration = initialValue
    ///             }
    ///             get { lock.withLock { _value } }
    ///             set { lock.withLock { _value = newValue } }
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
