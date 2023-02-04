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
///             parameters: UpdateUserDataGatewayParameters,
///             completion: (ResultNoFailure<UpdateUserDataEntity>) -> Void
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
        case .success(let success): return .success(transform(success))
        case .failure: return .failure
        }
    }
    
    /// Returns a new result, mapping any success value using the given
    /// transformation and unwrapping the produced result.
    public func flatMap<NewSuccess>(
        _ transform: (Success) -> ResultNoFailure<NewSuccess>
    ) -> ResultNoFailure<NewSuccess> {
        switch self {
        case .success(let success): return transform(success)
        case .failure: return .failure
        }
    }
    
    /// Returns the success value as a throwing expression.
    public func get() throws -> Success {
        switch self {
        case .success(let success): return success
        case .failure: throw ResultNoFailureError()
        }
    }
}

// MARK: Equatable
extension ResultNoFailure: Equatable where Success: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.failure, .failure): return true
        case (.failure, .success): return false
        case (.success, .failure): return false
        case (.success(let lhs), .success(let rhs)): return lhs == rhs
        }
    }
}

// MARK: - Result No Failure Error
private struct ResultNoFailureError: VCoreError {
    // MARK: VCore Error
    var code: Int { 1000 }
    var description: String { VCoreLocalizationManager.shared.localizationProvider.resultNoFailureErrorDescription }
}
