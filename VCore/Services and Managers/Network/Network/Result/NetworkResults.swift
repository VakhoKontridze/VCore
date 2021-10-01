//
//  NetworkResults.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK: - Result
///// Represents either a success or a failure, including an associated value in each case.
//enum Result<Success, Failure> where Failure: Error {
//    /// Success, storing a `Success` value.
//    case success(Success)
//
//    /// Failure, storing a `Failure` value.
//    case failure(Failure)
//}

// MARK: - Result with No Failure
/// Represents either Success or Failure, including an associated value in success case.
public enum ResultNoFailure<Success> {
    /// Success, storing a `Success` value.
    case success(Success)
    
    /// Failure.
    case failure
}

// MARK: - Result with No Success
/// Represents either Success or Failure, including an associated value in failure case.
public enum ResultNoSuccess<Failure> where Failure: Error {
    /// Success.
    case success
    
    /// Failure, storing a `Failure` value.
    case failure(Failure)
}

// MARK: - Result with No Success and No Failure
/// Represents either Success or Failure.
public enum ResultNoSuccessNoFailure {
    /// Success.
    case success
    
    /// Failure.
    case failure
}
