//
//  JSONDecoderService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import UIKit

// MARK: - JSON Decoder Service
/// Object that decodes instances of data type from JSON objects.
public struct JSONDecoderService {
    // MARK: Initializers
    private init() {}

    // MARK: Decoding
    /// Decodes `JSON` from `Data`.
    public static func json(
        from data: Data
    ) -> Result<[String: Any], Error> {
        do {
            let jsonObject: Any = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            switch jsonObject as? [String: Any] {
            case let json?:
                return .success(json)
            
            case nil:
                return .failure(JSONDecoderError.failedToDecode(.init()))
            }
            
        } catch let error as NSError {
            return .failure(JSONDecoderError.failedToDecode(.init(
                nsError: error
            )))
        }
    }
    
    /// Decodes `JSON` `Array` from `Data`.
    public static func jsonArray(
        from data: Data
    ) -> Result<[[String: Any]], Error> {
        do {
            let jsonObject: Any = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            switch jsonObject as? [[String: Any]] {
            case let jsonArray?:
                return .success(jsonArray)
            
            case nil:
                return .failure(JSONDecoderError.failedToDecode(.init()))
            }
            
        } catch let error as NSError {
            return .failure(JSONDecoderError.failedToDecode(.init(
                nsError: error
            )))
        }
    }
    
    /// Decodes `Decodable` from `Data`.
    public static func entity<DecodedData: Decodable>(
        from data: Data
    ) -> Result<DecodedData, Error> {
        do {
            let data: DecodedData = try JSONDecoder().decode(DecodedData.self, from: data)
            return .success(data)
            
        } catch let error as NSError {
            return .failure(JSONDecoderError.failedToDecode(.init(
                nsError: error
            )))
        }
    }
}
