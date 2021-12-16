//
//  JSONDecoderService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import UIKit

// MARK: - JSON Decoder Service
/// Object that decodes instances of data types.
public struct JSONDecoderService {
    // MARK: Initializers
    private init() {}

    // MARK: Decoding
    /// Decodes `JSON` from `Data`.
    public static func json(from data: Data) throws -> [String: Any?] {
        guard
            let jsonObject: Any = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let json: [String: Any?] = jsonObject as? [String: Any?]
        else {
            throw JSONDecoderError.failedToDecode
        }
        
        return json
    }
    
    /// Decodes `JSON` `Array` from `Data`.
    public static func jsonArray(from data: Data) throws -> [[String: Any?]] {
        guard
            let jsonObject: Any = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let jsonArray: [[String: Any?]] = jsonObject as? [[String: Any?]]
        else {
            throw JSONDecoderError.failedToDecode
        }

        return jsonArray
    }
    
    /// Decodes `Decodable` from `Data`.
    public static func decodable<DecodedData: Decodable>(from data: Data) throws -> DecodedData {
        guard let decodedData: DecodedData = try? JSONDecoder().decode(DecodedData.self, from: data) else { throw JSONDecoderError.failedToDecode }
        return decodedData
    }
}
