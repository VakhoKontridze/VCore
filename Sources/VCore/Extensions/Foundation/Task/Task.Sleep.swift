//
//  Task.Sleep.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 20.06.22.
//

import Foundation

// MARK: - Task Sleep
extension Task where Success == Never, Failure == Never {
    /// Suspends the current task for at least the given duration in seconds.
    ///
    /// If the task is canceled before the time ends, this function throws `CancellationError`.
    ///
    /// This function doesn't block the underlying thread.
    ///
    ///     try Task.sleep(seconds: 1)
    ///
    public static func sleep(seconds duration: TimeInterval) async throws {
        guard duration >= 0 else { VCoreFatalError("`duration` must be greater than or equal to `0`") }

        try await sleep(nanoseconds: UInt64(duration * 1_000_000_000))
    }
}
