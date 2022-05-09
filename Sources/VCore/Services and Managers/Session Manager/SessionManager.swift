//
//  SessionManager.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK: - Session Manager
/// Session manager that works with `AtomicInteger` to manage sessions with unique identifiers.
///
/// Object contains `shared` instance, but can also be initialized for separate incrementation.
///
/// Usage Example:
///
///     let sessionManager: SessionManager = .init()
///
///     Task(operation: {
///         do {
///             let sessionID: Int = sessionManager.newSessionID
///
///             let request: NetworkRequest = .init(url: "https://httpbin.org/get")
///             let result: [String: Any?] = try await NetworkClient.default.json(from: request)
///
///             guard sessionManager.sessionIsValid(id: sessionID) else { return }
///
///             print(result)
///
///         } catch {
///             print(error.localizedDescription)
///         }
///     })
///
public final class SessionManager {
    // MARK: Properties
    private let dispatchSemaphore: DispatchSemaphore = .init(value: 1)
    
    private let atomicInteger: AtomicInteger = .init(initialValue: 0)
    
    /// Current session ID. Default to `-1` without any prior incrementation.
    private(set) public var currentSessionID: Int = -1
    
    /// Generates thread-safe, auto-incremented session identifier from `AtomicInteger`.
    public var newSessionID: Int {
        dispatchSemaphore.wait()
        defer { dispatchSemaphore.signal() }
        
        currentSessionID = atomicInteger.value
        return currentSessionID
    }
    
    /// Shared instance of `NetworkSessionManager`.
    public static let shared: AtomicInteger = .init()
    
    // MARK: Initializers
    public init() {}

    // MARK: Validation
    /// Validates session identifier against latest generated identifier.
    public func sessionIsValid(id sessionID: Int) -> Bool {
        sessionID == currentSessionID
    }
}
