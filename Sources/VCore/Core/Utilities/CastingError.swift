//
//  CastingError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.09.23.
//

import Foundation

/// Error that occurs during casting.
@MemberwiseInitializable(accessLevelModifier: .private)
nonisolated public struct CastingError: BaseErrorProtocol, Sendable {
    // MARK: Properties
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
    
    // MARK: Equatable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.description == rhs.description
    }
}
