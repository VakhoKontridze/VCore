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
/// For shared instance, refer to `GlobalSessionManager`.
///
///     let sessionManager: SessionManager = .init()
///
///     Task(operation: {
///         do {
///             let sessionID: Int = await sessionManager.newSessionID
///
///             let request: NetworkRequest = .init(url: "https://httpbin.org/get")
///             let result: [String: Any?] = try await NetworkClient.default.json(from: request)
///
///             guard await sessionManager.sessionIsValid(id: sessionID) else { return }
///
///             print(result)
///
///         } catch {
///             print(error.localizedDescription)
///         }
///     })
///
public actor SessionManager {
    // MARK: Properties
    private var value: Int
    
    // MARK: Initializers
    /// Initializes `SessionManager` with an initial ID.
    public init(initialID: Int = 0) {
        self.value = initialID
    }

    // MARK: Management
    /// Current session ID.
    public var currentSessionID: Int {
        value
    }
    
    /// Increments and returns current session ID.
    public var newSessionID: Int {
        value += 1
        return value
    }
    
    /// Validates session identifier against latest generated identifier.
    public func sessionIsValid(id sessionID: Int) -> Bool {
        value == sessionID
    }
}

// MARK: - Global Session Manager
/// Global instance of `SessionManager`.
///
///     Task(operation: {
///         do {
///             let sessionID: Int = await GlobalSessionManager.shared.newSessionID
///
///             let request: NetworkRequest = .init(url: "https://httpbin.org/get")
///             let result: [String: Any?] = try await NetworkClient.default.json(from: request)
///
///             guard await GlobalSessionManager.shared.sessionIsValid(id: sessionID) else { return }
///
///             print(result)
///
///         } catch {
///             print(error.localizedDescription)
///         }
///     })
///
@globalActor public final class GlobalSessionManager {
    public static let shared: SessionManager = .init()
}
