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
///     Task {
///         do {
///             let sessionID: Int = await sessionManager.generateNewID()
///
///             let request: URLRequest = ...
///             let (data, response): (Data, URLResponse) = try await URLSession.shared.data(for: request)
///
///             guard await sessionManager.isValidID(sessionID) else { return }
///
///             ...
///
///         } catch {
///             print(error.localizedDescription)
///         }
///     }
///
public actor SessionManager {
    // MARK: Properties
    private var id: Int

    // MARK: Initializers
    /// Initializes `SessionManager` with an initial ID.
    public init(
        initialID id: Int = 0
    ) {
        self.id = id
    }
    
    // MARK: Management
    /// Current ID.
    public var currentID: Int {
        id
    }
    
    /// Increments and returns new ID.
    public func generateNewID() -> Int {
        id += 1
        return id
    }
    
    /// Validates ID against latest generated ID.
    public func isValidID(_ id: Int) -> Bool {
        self.id == id
    }
}

// MARK: - Global Session Manager
/// Global instance of `SessionManager`.
///
///     Task {
///         do {
///             let sessionID: Int = await GlobalSessionManager.shared.generateNewID()
///
///             let request: URLRequest = ...
///             let (data, response): (Data, URLResponse) = try await URLSession.shared.data(for: request)
///
///             guard await GlobalSessionManager.shared.isValidID(sessionID) else { return }
///
///             ...
///
///         } catch {
///             print(error.localizedDescription)
///         }
///     }
///
@globalActor
public final class GlobalSessionManager {
    public static let shared: SessionManager = .init()
}
