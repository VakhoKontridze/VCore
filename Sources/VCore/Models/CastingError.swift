//
//  CastingError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.09.23.
//

import Foundation

// MARK: - Casting Error
/// Error that occurs during casting.
public struct CastingError: VCoreError, Equatable {
    // MARK: Properties
    private let fromType: String
    private let toType: String

    // MARK: Initializers
    /// Initializes `CastingError` with types.
    public init(
        from fromType: String,
        to toType: String
    ) {
        self.fromType = fromType
        self.toType = toType
    }

    // MARK: Properties - VCore Error
    public let vCoreErrorCode: Int = 0

    public var vCoreErrorDescription: String { "Failed to cast '\(fromType)' to '\(toType)'" }

    // MARK: Equatable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.vCoreErrorCode == rhs.vCoreErrorCode
    }
}
