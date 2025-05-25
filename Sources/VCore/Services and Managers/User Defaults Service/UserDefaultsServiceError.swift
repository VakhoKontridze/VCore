//
//  UserDefaultsServiceError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 08.09.24.
//

import Foundation

// MARK: - User Defaults Service Error
/// An error that occurs during the operations in `UserDefaultsService`.
@MemberwiseInitializable(accessLevelModifier: .private)
public struct UserDefaultsServiceError: BaseErrorProtocol, Sendable {
    // MARK: Properties
    public static let domain: String = "com.vcore.userdefaultsservice"
    public let code: Int
    public let description: String
    
    // MARK: Properties
    /// Indicates that get operation has failed.
    public static var failedToGet: Self {
        .init(
            code: 1,
            description: "Data cannot be retrieved from 'UserDefaults'"
        )
    }

    /// Indicates that set operation has failed.
    public static var failedToSet: Self {
        .init(
            code: 2,
            description: "Data cannot be set to 'UserDefaults'"
        )
    }

    /// Indicates that delete operation has failed.
    public static var failedToDelete: Self {
        .init(
            code: 3,
            description: "Data cannot be deleted from 'UserDefaults'"
        )
    }
}
