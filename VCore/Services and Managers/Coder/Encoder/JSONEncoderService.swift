//
//  JSONEncoderService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK: - JSON Encoder Service
/// Object that encodes instances of data type as JSON objects.
public struct JSONEncoderService {
    // MARK: Initializers
    private init() {}

    // MARK: Encoding
    /// Encodes `Any` to `Data`.
    public static func data(from data: Any) throws -> Data {
        guard let data: Data = try? JSONSerialization.data(withJSONObject: data) else { throw JSONEncoderError.failedToEncode }
        return data
    }
    
    /// Encodes `Encodable` to `Data`.
    public static func data<EncodingData: Encodable>(from data: EncodingData) throws -> Data {
        guard let data: Data = try? JSONEncoder().encode(data) else { throw JSONEncoderError.failedToEncode }
        return data
    }
    
    /// Encodes `Encodable` to `JSON`.
    public static func json<EncodingData: Encodable>(from data: EncodingData) throws -> [String: Any?] {
        guard
            let jsonData: Data = try? JSONEncoder().encode(data),
            let json: [String: Any?] = try? JSONDecoderService.json(from: jsonData)
        else {
            throw JSONEncoderError.failedToEncode
        }
        
        return json
    }
}
