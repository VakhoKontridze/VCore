//
//  NetworkSessionManager.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK:- Network Session Manager
/// Network session manager that works with `AtomicInteger` to manage sessions with unique identifiers
///
/// Object contains `shared` instance, but can also be initialized for separate incrementation
public final class NetworkSessionManager {
    // MARK: Properties
    private let dispatchSemaphore: DispatchSemaphore = .init(value: 1)
    private let atomicInteger: AtomicInteger = .init(initialValue: 0)
    
    /// Current session ID. Default to `-1` without any prior incrementation.
    private(set) public var currentSessionID: Int = -1
    
    /// Shared instance of `NetworkSessionManager`
    public static let shared: AtomicInteger = .init()
    
    // MARK: Initializers
    public init() {}
}

// MARK:- Session
extension NetworkSessionManager {
    /// Generates thread-safe, auto-incremented session identifier from `AtomicInteger`
    public var newSessionID: Int {
        dispatchSemaphore.wait()
        defer { dispatchSemaphore.signal() }
        
        currentSessionID = atomicInteger.value
        return currentSessionID
    }
    
    /// Validates session identifier against latest generated identifier
    public func sessionIsValid(id sessionID: Int) -> Bool {
        sessionID == currentSessionID
    }
}
