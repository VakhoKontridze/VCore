//
//  JSONTypeCasts.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK: - Primitive JSON Type Casts
extension Optional where Wrapped == Any {
    /// Casts `Optional` `Any` to `Int`.
    ///
    /// If type is `Bool`, `1` is returned if `true`, and `0` if `false`.
    public var toInt: Int? {
        switch self {
        case let int as Int: int
        case let float as Float: Int(float)
        case let double as Double: Int(double)
        case let bool as Bool: bool ? 1 : 0
        case let char as Character: char.wholeNumberValue
        case let string as String: Int(string)
        default: nil
        }
    }
    
    /// Casts `Optional` `Any` to `Float`.
    ///
    /// If type is `Bool`, `1` is returned if `true`, and `0` if `false`.
    public var toFloat: Float? {
        switch self {
        case let int as Int: Float(int)
        case let float as Float: float
        case let double as Double: Float(double)
        case let bool as Bool: bool ? 1 : 0
        case let char as Character: char.wholeNumberValue.map { Float($0) }
        case let string as String: Float(string)
        default: nil
        }
    }
    
    /// Casts `Optional` `Any` to `Double`.
    ///
    /// If type is `Bool`, `1` is returned if `true`, and `0` if `false`.
    public var toDouble: Double? {
        switch self {
        case let int as Int: Double(int)
        case let float as Float: Double(float)
        case let double as Double: double
        case let bool as Bool: bool ? 1 : 0
        case let char as Character: char.wholeNumberValue.map { Double($0) }
        case let string as String: Double(string)
        default: nil
        }
    }
    
    /// Casts `Optional` `Any` to `Bool`.
    ///
    /// If type is `Int`, `Float`, or `Double`, `true` is returned if value is non-zero.
    ///
    /// If type is `Char`, `true` is returned if `wholeNumberValue` is non-zero.
    ///
    /// If type is `String`, `true` is returned if value is `"1"`, `"true"`, `t`, `yes`, or`y`.
    public var toBool: Bool? {
        switch self {
        case let int as Int: int != 0
        case let float as Float: float != 0
        case let double as Double: double != 0
        case let bool as Bool: bool
        case let char as Character: char.wholeNumberValue != 0
        case let string as String: ["1", "true", "t", "yes", "y"].contains(string.lowercased())
        default: nil
        }
    }
    
    /// Casts `Optional` `Any` to `Character`.
    ///
    /// If type is `Int`, and value is not a single-digit, crashes would occur.
    ///
    /// If type is `Float` or `Double`, value is casted to `Int` before casting to `Character`.
    /// If is not a single-digit, crashes would occur.
    ///
    /// If type is `Bool`, `1` is returned if `true`, and `0` if `false`.
    ///
    /// If type is `String`, and value contains multiple `Character`s, crashes would occur.
    public var toChar: Character? {
        switch self {
        case let int as Int: Character(String(int))
        case let float as Float: Character(String(Int(float)))
        case let double as Double: Character(String(Int(double)))
        case let bool as Bool: bool ? "1" : "0"
        case let char as Character: char
        case let string as String: Character(string)
        default: nil
        }
    }
    
    /// Casts `Optional` `Any` to `String`.
    public var toString: String? {
        switch self {
        case let int as Int: String(int)
        case let float as Float: String(float)
        case let double as Double: String(double)
        case let bool as Bool: String(bool)
        case let char as Character: String(char)
        case let string as String: string
        default: nil
        }
    }
}

// MARK: - Collection JSON Type Casts
extension Optional where Wrapped == Any {
    /// Casts `Optional` `Any` to `JSON`.
    public var toJSON: [String: Any?]? {
        self as? [String: Any?]
    }
    
    /// Casts `Optional` `Any` to `JSON` `Array`.
    public var toJSONArray: [[String: Any?]]? {
        self as? [[String: Any?]]
    }
}

// MARK: - Unwrapped Collection JSON Type Casts
extension Optional where Wrapped == Any {
    /// Casts `Optional` `Any` to wrapped`JSON`.
    public var toUnwrappedJSON: [String: Any?] {
        toJSON ?? [:]
    }
    
    /// Casts `Optional` `Any` to wrapped `JSON` `Array`.
    public var toUnwrappedJSONArray: [[String: Any?]] {
        toJSONArray ?? []
    }
}
