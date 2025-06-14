//
//  ResultNoFailure.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK: - Result with No Failure
/// Represents either Success or Failure, including an associated value in success case.
///
/// Can be used to represent a result type that has no associated Failure type to it.
/// For instance, a network request that doesn't return an error.
///
///     struct UpdateUserDataGateway {
///         func fetch(
///             parameters: UpdateUserDataGatewayInput,
///             completion: (ResultNoFailure<UpdateUserGatewayOutput>) -> Void
///         )
///     }
///
public enum ResultNoFailure<Success> {
    // MARK: Cases
    /// Success, storing a `Success` value.
    case success(Success)
    
    /// Failure.
    case failure
    
    // MARK: Methods
    /// Returns a new result, mapping any success value using the given transformation.
    public func map<NewSuccess>(
        _ transform: (Success) -> NewSuccess
    ) -> ResultNoFailure<NewSuccess> {
        switch self {
        case .success(let success): .success(transform(success))
        case .failure: .failure
        }
    }
    
    /// Returns a new result, mapping any success value using the given
    /// transformation and unwrapping the produced result.
    public func flatMap<NewSuccess>(
        _ transform: (Success) -> ResultNoFailure<NewSuccess>
    ) -> ResultNoFailure<NewSuccess> {
        switch self {
        case .success(let success): transform(success)
        case .failure: .failure
        }
    }
    
    /// Returns the success value as a throwing expression.
    public func get() throws -> Success {
        switch self {
        case .success(let success): success
        case .failure: throw CastingError(from: "ResultNoFailure", to: String(describing: Success.self))
        }
    }
}

// MARK: Equatable
extension ResultNoFailure: Equatable where Success: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.failure, .failure): true
        case (.failure, .success): false
        case (.success, .failure): false
        case (.success(let lhs), .success(let rhs)): lhs == rhs
        }
    }
}

// MARK: Sendable
extension ResultNoFailure: Sendable where Success: Sendable {}
