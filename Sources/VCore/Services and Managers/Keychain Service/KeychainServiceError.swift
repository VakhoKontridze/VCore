//
//  KeychainServiceError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 23.07.22.
//

import Foundation

// MARK: - Keychain Service Error
/// An error that occurs during the operations in `KeychainService`.
@MemberwiseInitializable(accessLevelModifier: .private)
public struct KeychainServiceError: BaseErrorProtocol, Sendable {
    // MARK: Properties
    public static let domain: String = "com.vcore.keychainservice"
    public let code: Int
    public let description: String
    
    // MARK: Initializers
    /// Indicates that get operation has failed.
    public static var failedToGet: Self {
        .init(
            code: 1,
            description: "Data cannot be retrieved from 'Security' framework"
        )
    }
    
    /// Indicates that set operation has failed.
    public static var failedToSet: Self {
        .init(
            code: 2,
            description: "Data cannot be set to 'Security' framework"
        )
    }
    
    /// Indicates that delete operation has failed.
    public static var failedToDelete: Self {
        .init(
            code: 3,
            description: "Data cannot be deleted from 'Security' framework"
        )
    }
}
