//
//  ResultNoSuccess.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 08.06.22.
//

import Foundation

// MARK: - Result with No Success
/// Represents either Success or Failure, including an associated value in failure case.
///
/// Can be used to represent a result type that has no associated Success type to it.
/// For instance, a network request that doesn't return an object.
///
///     struct UpdateUserDataGateway {
///         func fetch(
///             parameters: UpdateUserDataGatewayParameters,
///             completion: (ResultNoSuccess<any Error>) -> Void
///         )
///     }
///
public enum ResultNoSuccess<Failure> where Failure: Error {
    // MARK: Cases
    /// Success.
    case success
    
    /// Failure, storing a `Failure` value.
    case failure(Failure)
    
    // MARK: Methods
    /// Returns a new result, mapping any failure value using the given transformation.
    public func mapError<NewFailure>(
        _ transform: (Failure) -> NewFailure
    ) -> ResultNoSuccess<NewFailure>
        where NewFailure: Error
    {
        switch self {
        case .success: .success
        case .failure(let failure): .failure(transform(failure))
        }
    }
    
    /// Returns a new result, mapping any failure value using the given
    /// transformation and unwrapping the produced result.
    public func flatMapError<NewFailure>(
        _ transform: (Failure) -> ResultNoSuccess<NewFailure>
    ) -> ResultNoSuccess<NewFailure>
        where NewFailure: Error
    {
        switch self {
        case .success: .success
        case .failure(let failure): transform(failure)
        }
    }
}

// MARK: Equatable
extension ResultNoSuccess: Equatable where Failure: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.failure(let lhs), .failure(let rhs)): lhs == rhs
        case (.failure, .success): false
        case (.success, .failure): false
        case (.success, .success): true
        }
    }
}
