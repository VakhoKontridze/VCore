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
    public static func data(
        from data: Any
    ) -> Result<Data, Error> {
        do {
            let data: Data = try JSONSerialization.data(withJSONObject: data)
            return .success(data)
            
        } catch let error {
            return .failure(JSONEncoderError.failedToEncode(.init(
                nsError: error as NSError
            )))
        }
    }
    
    /// Encodes `Encodable` to `Data`.
    public static func data<EncodingData: Encodable>(
        from data: EncodingData
    ) -> Result<Data, Error> {
        do {
            let data: Data = try JSONEncoder().encode(data)
            return .success(data)
            
        } catch let error {
            return .failure(JSONEncoderError.failedToEncode(.init(
                nsError: error as NSError
            )))
        }
    }
    
    /// Encodes `Encodable` to `JSON`.
    public static func json<EncodingData: Encodable>(
        from data: EncodingData
    ) -> Result<[String: Any], Error> {
        do {
            let jsonData: Data = try JSONEncoder().encode(data)
            
            switch JSONDecoderService.json(from: jsonData) {
            case .success(let data):
                return .success(data)
            
            case .failure(let error):
                return .failure(JSONEncoderError.failedToEncode(.init(
                    jsonDecoderError: error as? JSONDecoderError
                )))
            }
            
        } catch let error {
            return .failure(JSONEncoderError.failedToEncode(.init(
                nsError: error as NSError
            )))
        }
    }
}
