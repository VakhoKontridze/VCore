//
//  ViewResetter.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 26.09.23.
//

import Foundation

// MARK: - View Resetter
/// Object inside the environment of `ViewResettingContainer` to trigger view resets on demand.
///
/// For additional info, refer to `ViewResettingContainer`.
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@Observable
@MainActor
public final class ViewResetter {
    // MARK: Properties
    private(set) var value: Int = 0

    // MARK: Initializers
    init() {}

    // MARK: Trigger
    /// Triggers reset inside `ViewResettingContainer`.
    public func trigger() {
        value += 1
    }

    // MARK: Callable Object
    /// Triggers reset inside `ViewResettingContainer`.
    public func callAsFunction() {
        trigger()
    }
}
