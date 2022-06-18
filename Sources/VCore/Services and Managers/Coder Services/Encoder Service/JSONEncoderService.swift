//
//  JSONEncoderService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK: - JSON Encoder Service
/// Object that encodes instances of data types.
public struct JSONEncoderService {
    // MARK: Initializers
    private init() {}

    // MARK: Encoding
    /// Encodes `Any` to `Data`.
    public static func data(
        any: Any?
    ) throws -> Data {
        guard
            let any = any,
            let data: Data = try? JSONSerialization.data(withJSONObject: any)
        else {
            throw JSONEncoderError.failedToEncode
        }
        
        return data
    }
    
    /// Encodes `Encodable` to `Data`.
    public static func data<T>(
        encodable: T
    ) throws -> Data
        where T: Encodable
    {
        guard let data: Data = try? JSONEncoder().encode(encodable) else { throw JSONEncoderError.failedToEncode }
        return data
    }
    
    /// Encodes `Encodable` to `JSON`.
    public static func json<T>(
        encodable: T
    ) throws -> [String: Any?]
        where T: Encodable
    {
        guard
            let jsonData: Data = try? JSONEncoder().encode(encodable),
            let json: [String: Any?] = try? JSONDecoderService.json(data: jsonData)
        else {
            throw JSONEncoderError.failedToEncode
        }
        
        return json
    }
    
    /// Encodes `Encodable` to `JSON` `Array`.
    public static func jsonArray<T>(
        encodable: T
    ) throws -> [[String: Any?]]
        where T: Encodable
    {
        guard
            let jsonData: Data = try? JSONEncoder().encode(encodable),
            let jsonArray: [[String: Any?]] = try? JSONDecoderService.jsonArray(data: jsonData)
        else {
            throw JSONEncoderError.failedToEncode
        }
        
        return jsonArray
    }
}
