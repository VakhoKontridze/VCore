//
//  JSONDecoderService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK: - JSON Decoder Service
/// Object that decodes instances of data types.
public struct JSONDecoderService {
    // MARK: Initializers
    private init() {}

    // MARK: Decoding
    /// Decodes `Data` to `JSON`.
    public static func json(data: Data) throws -> [String: Any?] {
        guard
            let jsonObject: Any = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let json: [String: Any?] = jsonObject as? [String: Any?]
        else {
            throw JSONDecoderError.failedToDecode
        }
        
        return json
    }
    
    /// Decodes `Data` to `JSON` `Array`.
    public static func jsonArray(data: Data) throws -> [[String: Any?]] {
        guard
            let jsonObject: Any = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let jsonArray: [[String: Any?]] = jsonObject as? [[String: Any?]]
        else {
            throw JSONDecoderError.failedToDecode
        }

        return jsonArray
    }
    
    /// Decodes `Data` to `Decodable`.
    public static func decodable<T: Decodable>(data: Data) throws -> T {
        guard let decodable: T = try? JSONDecoder().decode(T.self, from: data) else { throw JSONDecoderError.failedToDecode }
        return decodable
    }
    
    /// Decodes `JSON` to `Decodable`.
    public static func decodable<T: Decodable>(json: [String: Any?]) throws -> T {
        guard let data: Data = try? JSONSerialization.data(withJSONObject: json) else {
            throw JSONEncoderError.failedToEncode
        }
        
        return try decodable(data: data)
    }
    
    /// Decodes `JSON` `Array` to `Decodable`.
    public static func decodable<T: Decodable>(jsonArray: [[String: Any?]]) throws -> T {
        guard let data: Data = try? JSONSerialization.data(withJSONObject: jsonArray) else {
            throw JSONEncoderError.failedToEncode
        }
        
        return try decodable(data: data)
    }
}
