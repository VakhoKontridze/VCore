//
//  CastingError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.09.23.
//

import Foundation

// MARK: - Casting Error
/// Error that occurs during casting.
@MemberwiseInitializable(accessLevelModifier: .private)
public struct CastingError: BaseErrorProtocol, Sendable {
    public static let domain: String = "com.vcore"
    public let code: Int
    public let description: String
    
    // MARK: Initializers
    /// Indicates that casting has failed.
    public init(
        from fromType: String,
        to toType: String
    ) {
        self.init(
            code: 0,
            description: "Failed to cast '\(fromType)' to '\(toType)'"
        )
    }
}
