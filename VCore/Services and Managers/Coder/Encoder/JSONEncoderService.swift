//
//  JSONEncoderService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK:- JSON Encoder Service
/// Object that encodes instances of data type as JSON objects
public struct JSONEncoderService {
    // MARK: Initializers
    private init() {}
}

// MARK:- Encoding
extension JSONEncoderService {
    /// Encodes `Any` to `Data`
    public static func data(
        from data: Any
    ) -> Result<Data, JSONEncodingError> {
        do {
            let data = try JSONSerialization.data(withJSONObject: data)
            return .success(data)
            
        } catch let error {
            return .failure(.failedToEncode(.init(
                domain: (error as NSError).domain,
                code: (error as NSError).code,
                description: error.localizedDescription
            )))
        }
    }
    
    /// Encodes `Encodable` to `Data`
    public static func data<EncodingData: Encodable>(
        from data: EncodingData
    ) -> Result<Data, JSONEncodingError> {
        do {
            let data = try JSONEncoder().encode(data)
            return .success(data)
            
        } catch let error {
            return .failure(.failedToEncode(.init(
                domain: (error as NSError).domain,
                code: (error as NSError).code,
                description: error.localizedDescription
            )))
        }
    }
    
    /// Encodes `Encodable` to `JSON`
    public static func json<EncodingData: Encodable>(
        from data: EncodingData
    ) -> Result<[String: Any], JSONEncodingError> {
        do {
            let jsonData: Data = try JSONEncoder().encode(data)
            
            switch JSONDecoderService.json(from: jsonData) {
            case .success(let data):
                return .success(data)
            
            case .failure(let error):
                return .failure(.failedToEncode(.init(
                    domain: error.domain,
                    code: error.code,
                    description: error.secondaryDescription
                )))
            }
            
        } catch let error {
            return .failure(.failedToEncode(.init(
                domain: (error as NSError).domain,
                code: (error as NSError).code,
                description: error.localizedDescription
            )))
        }
    }
}
