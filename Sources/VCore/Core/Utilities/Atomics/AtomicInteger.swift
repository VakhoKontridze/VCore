//
//  AtomicInteger.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.08.25.
//

import Foundation

/// Thread-safe, automatically incremented `Int`.
///
///     let idGenerator: AtomicInteger = .init()
///
///     func generateID() async -> Int {
///         await idGenerator.getAndIncrement()
///     }
///
/// For shared instance, refer to `GlobalAtomicInteger`.
public typealias AtomicInteger = AtomicNumber<Int>

/// Global instance of `AtomicInteger`.
///
///     func generateID() async -> Int {
///         await GlobalAtomicInteger.shared.getAndIncrement()
///     }
///
public nonisolated final class GlobalAtomicInteger { // No `@globalActor` needed
    // MARK: Properties
    /// Shared instance of `AtomicInteger`.
    public static let shared: AtomicInteger = .init()
    
    // MARK: Initializers
    private init() {}
}
