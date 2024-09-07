//
//  UserDefaultsServiceError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 08.09.24.
//

import Foundation

// MARK: - User Defaults Service Error
/// An error that occurs during the operations in `UserDefaultsService`.
public struct UserDefaultsServiceError: VCoreError, Equatable {
    // MARK: Properties
    private let code: Code

    // MARK: Initializers
    /// Initializes `UserDefaultsServiceError` with the given error code.
    public init(_ code: Code) {
        self.code = code
    }

    // MARK: Code
    /// Error code.
    public enum Code: Int, Equatable {
        /// Indicates that get operation has failed.
        case failedToGet

        /// Indicates that set operation has failed.
        case failedToSet

        /// Indicates that delete operation has failed.
        case failedToDelete
    }

    // MARK: VCore Error
    public var vCoreErrorCode: Int { code.rawValue }

    public var vCoreErrorDescription: String {
        switch code {
        case .failedToGet: "Data cannot be retrieved from 'UserDefaults'"
        case .failedToSet: "Data cannot be set to 'UserDefaults'"
        case .failedToDelete: "Data cannot be deleted from 'UserDefaults'"
        }
    }

    // MARK: Equatable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.code == rhs.code
    }
}
