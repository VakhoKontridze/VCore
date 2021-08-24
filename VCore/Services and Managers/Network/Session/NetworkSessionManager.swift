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
    private let atomicInteger: AtomicInteger = .init(initialValue: 0)
    private var currentSessionID: Int = -1
    
    /// Shared instance of `NetworkSessionManager`
    public static let shared: AtomicInteger = .init()
    
    // MARK: Initializers
    public init() {}
}

// MARK:- Session
extension NetworkSessionManager {
    /// Generates thread-safe, auto-incremented session identifier from `AtomicInteger`
    public var newSessionID: Int {
        currentSessionID = atomicInteger.value
        return currentSessionID
    }
    
    /// Validates session identifier against latest generated identifier
    public func sessionIsValid(id sessionID: Int) -> Bool {
        sessionID == currentSessionID
    }
}
