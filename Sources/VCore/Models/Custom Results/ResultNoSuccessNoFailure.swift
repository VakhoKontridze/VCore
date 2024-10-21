//
//  ResultNoSuccessNoFailure.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 08.06.22.
//

import Foundation

// MARK: - Result with No Success and No Failure
/// Represents either Success or Failure.
///
/// Can be used to represent a result type that has no associated Success or Failure types to it.
/// For instance, a network request that doesn't return an object or an error.
///
///     struct UpdateUserDataGateway {
///         func fetch(
///             parameters: UpdateUserDataParameters,
///             completion: (ResultNoSuccessNoFailure) -> Void
///         )
///     }
///
public enum ResultNoSuccessNoFailure: Equatable, Sendable {
    /// Success.
    case success
    
    /// Failure.
    case failure
}
