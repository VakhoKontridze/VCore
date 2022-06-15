//
//  ResultNoSuccessNoFailure.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 08.06.22.
//

import Foundation

// MARK: - Result with No Success and No Failure
/// Represents either Success or Failure.
public enum ResultNoSuccessNoFailure {
    /// Success.
    case success
    
    /// Failure.
    case failure
}

// MARK: - Equatable
extension ResultNoSuccessNoFailure: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.failure, .failure): return true
        case (.failure, .success): return false
        case (.success, .failure): return false
        case (.success, .success): return true
        }
    }
}
