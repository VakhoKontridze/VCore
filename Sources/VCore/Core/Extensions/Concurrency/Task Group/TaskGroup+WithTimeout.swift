//
//  TaskGroup+WithTimeout.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

import Foundation

/// Performs asynchronous operation with a timeout.
///
///     try await withTimeout(
///         timeout: .seconds(60),
///         timeoutError: NotificationServiceError.failedToRegister
///     ) { [weak self] in
///         guard let self else { return }
///
///         while true {
///             let registrationResult: ResultNoSuccess<any Error>? = await registrationResult
///             try Task.checkCancellation()
///
///             if let registrationResult {
///                 switch registrationResult {
///                 case .success:
///                     return
///
///                 case .failure(let error):
///                     Logger.notificationService.error("Failed to register for push notifications: '\(error)'")
///                     throw error
///                 }
///
///             } else {
///                 try await Task.sleep(for: .seconds(0.1))
///                 try Task.checkCancellation()
///             }
///         }
///     }
///
public func withTimeout<ResultType>(
    of resultType: ResultType.Type = ResultType.self,
    isolation: isolated (any Actor)? = #isolation,
    timeout: Duration,
    timeoutError: @autoclosure @escaping @Sendable () -> any Error = WithTimeoutError.timeout,
    operation: @escaping @Sendable () async throws -> ResultType
) async throws -> ResultType
    where ResultType: Sendable
{
    try await withThrowingTaskGroup(
        of: resultType,
        isolation: isolation
    ) { group in
        defer { group.cancelAll() }

        group.addTask {
            try await operation()
        }

        group.addTask {
            try await Task.sleep(for: timeout)
            try Task.checkCancellation()

            throw timeoutError()
        }

        guard
            let result: ResultType = try await group.next()
        else {
            throw WithTimeoutError.failedToGetResult
        }

        return result
    }
}

/// Error that occurs during the operation in `withTimeout(...)`.
@MemberwiseInitializable(accessLevelModifier: .private)
nonisolated public struct WithTimeoutError: BaseErrorProtocol, Equatable {
    // MARK: Properties
    public static let domain: String =  "com.vakhtang-kontridze.vcore.with-timeout"
    public let code: Int
    public let description: String

    // MARK: Initializers
    /// Indicates that timeout has occurred.
    public static var timeout: Self {
        .init(
            code: 1,
            description: "Asynchronous operation timed out"
        )
    }
    
    /// Indicates that operation failed to obtain the result.
    public static var failedToGetResult: Self {
        .init(
            code: 2,
            description: "Failed to get a result from the asynchronous operation in the given time frame"
        )
    }
    
    // MARK: Equatable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.code == rhs.code
    }
}
