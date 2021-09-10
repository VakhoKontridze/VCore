//
//  JSONEncoderService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK:- JSON Encoder Service
struct JSONEncoderService {
    // MARK: Initializers
    private init() {}
}

// MARK:- Encoding
extension JSONEncoderService {
    static func json<EncodingData>(
        from data: EncodingData
    ) -> Result<Data, NetworkError> {
        do {
            let data = try JSONSerialization.data(withJSONObject: data)
            return .success(data)
            
        } catch let error {
            return .failure(.other(from: error))
        }
    }
    
    static func json<EncodingData: Encodable>(
        from data: EncodingData
    ) -> Result<[String: Any], NetworkError> {
        do {
            let jsonData: Data = try JSONEncoder().encode(data)
            return JSONDecoderService.json(from: jsonData)
            
        } catch let error {
            return .failure(.other(from: error))
        }
    }
    
    static func entity<EncodingData: Encodable>(
        from data: EncodingData
    ) -> Result<Data, NetworkError> {
        do {
            let data = try JSONEncoder().encode(data)
            return .success(data)
            
        } catch let error {
            return .failure(.other(from: error))
        }
    }
}
