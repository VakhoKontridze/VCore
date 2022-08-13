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
///     Task(operation: {
///         do {
///             let sessionID: Int = await SessionManager.shared.newSessionID
///
///             let request: NetworkRequest = .init(url: "https://httpbin.org/get")
///             let result: [String: Any?] = try await NetworkClient.default.json(from: request)
///
///             guard await SessionManager.shared.sessionIsValid(id: sessionID) else { return }
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
    
    /// Shared instance of `SessionManager`.
    public static let shared: SessionManager = .init()
    
    // MARK: Initializers
    /// Initializes `SessionManager` with an initial ID.
    public init(initialID: Int = 0) {
        self.value = initialID
    }

    // MARK: ???
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
