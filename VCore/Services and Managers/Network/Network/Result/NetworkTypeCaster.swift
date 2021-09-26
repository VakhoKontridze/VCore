//
//  NetworkTypeCaster.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK: - Network Type Caster
/// Casts `Any` to subsequent types
public struct NetworkTypeCaster {
    // MARK: Initializers
    private init() {}

    // MARK: Type Casts
    /// Casts `Any` to `JSON`
    public static func toJSON(_ data: Any?) -> [String: Any]? {
        data as? [String: Any]
    }

    /// Casts `Any` to `JSON` `Array`
    public static func toJSONArray(_ data: Any?) -> [[String: Any]]? {
        data as? [[String: Any]]
    }

    /// Casts `Any` to `Int`
    public static func toInt(_ data: Any?) -> Int? {
        switch data {
        case let int as Int: return int
        case let float as Float: return .init(float)
        case let double as Double: return .init(double)
        case let bool as Bool: return bool ? 1 : 0
        case let string as String: return .init(string)
        default: return nil
        }
    }
    
    /// Casts `Any` to `Float`
    public static func toFloat(_ data: Any?) -> Float? {
        switch data {
        case let int as Int: return .init(int)
        case let float as Float: return float
        case let double as Double: return .init(double)
        case let bool as Bool: return bool ? 1 : 0
        case let string as String: return .init(string)
        default: return nil
        }
    }

    /// Casts `Any` to `Double`
    public static func toDouble(_ data: Any?) -> Double? {
        switch data {
        case let int as Int: return .init(int)
        case let double as Double: return double
        case let bool as Bool: return bool ? 1 : 0
        case let string as String: return .init(string)
        default: return nil
        }
    }

    /// Casts `Any` to `Bool`
    public static func toBool(_ data: Any?) -> Bool? {
        switch data {
        case let int as Int: return int != 0
        case let float as Float: return float != 0
        case let double as Double: return double != 0
        case let bool as Bool: return bool
        case let string as String: return ["true", "t", "1", "y", "yes"].contains(string.lowercased())
        default: return nil
        }
    }

    /// Casts `Any` to `String`
    public static func toString(_ data: Any?) -> String? {
        switch data {
        case let int as Int: return .init(int)
        case let float as Float: return .init(float)
        case let double as Double: return .init(double)
        case let bool as Bool: return .init(bool)
        case let string as String: return string
        default: return nil
        }
    }

    // MARK: Wrapped Type Casts
    /// Casts `Any` to wrapped`JSON`
    public static func toWrappedJSON(_ data: Any?) -> [String: Any] {
        toJSON(data) ?? [:]
    }
    
    /// Casts `Any` to wrapped `JSON` `Array`
    public static func toWrappedJSONArray(_ data: Any?) -> [[String: Any]] {
        toJSONArray(data) ?? []
    }
}
