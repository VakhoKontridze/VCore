//
//  NetworkTypeCasts.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK: Type Casts
extension Optional where Wrapped == Any {
    /// Casts `Optional` `Any` to `JSON`.
    public var toJSON: [String: Any?]? {
        self as? [String: Any?]
    }

    /// Casts `Optional` `Any` to `JSON` `Array`.
    public var toJSONArray: [[String: Any?]]? {
        self as? [[String: Any?]]
    }

    /// Casts `Optional` `Any` to `Int`.
    public var toInt: Int? {
        switch self {
        case let int as Int: return int
        case let float as Float: return .init(float)
        case let double as Double: return .init(double)
        case let bool as Bool: return bool ? 1 : 0
        case let string as String: return .init(string)
        default: return nil
        }
    }

    /// Casts `Optional` `Any` to `Float`.
    public var toFloat: Float? {
        switch self {
        case let int as Int: return .init(int)
        case let float as Float: return float
        case let double as Double: return .init(double)
        case let bool as Bool: return bool ? 1 : 0
        case let string as String: return .init(string)
        default: return nil
        }
    }

    /// Casts `Optional` `Any` to `Double`.
    public var toDouble: Double? {
        switch self {
        case let int as Int: return .init(int)
        case let double as Double: return double
        case let bool as Bool: return bool ? 1 : 0
        case let string as String: return .init(string)
        default: return nil
        }
    }

    /// Casts `Optional` `Any` to `Bool`.
    public var toBool: Bool? {
        switch self {
        case let int as Int: return int != 0
        case let float as Float: return float != 0
        case let double as Double: return double != 0
        case let bool as Bool: return bool
        case let string as String: return ["true", "t", "1", "y", "yes"].contains(string.lowercased())
        default: return nil
        }
    }

    /// Casts `Optional` `Any` to `String`.
    public var toString: String? {
        switch self {
        case let int as Int: return .init(int)
        case let float as Float: return .init(float)
        case let double as Double: return .init(double)
        case let bool as Bool: return .init(bool)
        case let string as String: return string
        default: return nil
        }
    }
}

// MARK: Wrapped Type Casts
extension Optional where Wrapped == Any {
    /// Casts `Optional` `Any` to wrapped`JSON`.
    public var toWrappedJSON: [String: Any?] {
        toJSON ?? [:]
    }

    /// Casts `Optional` `Any` to wrapped `JSON` `Array`.
    public var toWrappedJSONArray: [[String: Any?]] {
        toJSONArray ?? []
    }
}
