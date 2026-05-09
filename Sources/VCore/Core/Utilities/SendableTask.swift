//
//  SendableTask.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/5/26.
//

import Foundation
import os

/// `Sendable` `Task` wrapper.
nonisolated public final class SendableTask<Success, Failure>: Sendable
    where
        Success: Sendable,
        Failure: Error
{
    // MARK: Properties
    /// Task.
    public var task: TaskType? {
        get { lock.withLock { $0 } }
        set { lock.withLock { $0 = newValue } }
    }
    
    private let lock: OSAllocatedUnfairLock<TaskType?> = .init(initialState: nil)
    
    // MARK: Initializers
    /// Initializes `SendableTask`.
    public init() {}
    
    // MARK: Types
    /// Task type.
    public typealias TaskType = Task<Success, Failure>
}
