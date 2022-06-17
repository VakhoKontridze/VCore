//
//  ResultNoSuccess.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 08.06.22.
//

import Foundation

// MARK: - Result with No Success
/// Represents either Success or Failure, including an associated value in failure case.
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
        case .success: return .success
        case .failure(let failure): return .failure(transform(failure))
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
        case .success: return .success
        case .failure(let failure): return transform(failure)
        }
    }
}

// MARK: Equatable
extension ResultNoSuccess: Equatable where Failure: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.failure(let lhs), .failure(let rhs)): return lhs == rhs
        case (.failure, .success): return false
        case (.success, .failure): return false
        case (.success, .success): return true
        }
    }
}
