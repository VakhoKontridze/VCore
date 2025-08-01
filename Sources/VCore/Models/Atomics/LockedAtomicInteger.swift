//
//  LockedAtomicInteger.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.08.25.
//

import Foundation

/// Thread-safe, automatically incremented `Int`.
///
///     let idGenerator: LockedAtomicInteger = .init()
///
///     func generateID() -> Int {
///         idGenerator.getAndIncrement()
///     }
///
/// For shared instance, refer to `shared`.
public typealias LockedAtomicInteger = LockedAtomicNumber<Int>

extension LockedAtomicInteger {
    /// Shared instance of `LockedAtomicNumber`.
    public static let shared: LockedAtomicNumber = .init()
}
