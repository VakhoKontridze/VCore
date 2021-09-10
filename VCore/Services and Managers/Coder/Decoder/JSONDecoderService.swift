//
//  JSONDecoderService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import UIKit

// MARK:- JSON Decoder Service
/// Object that decodes instances of data type from JSON objects
public struct JSONDecoderService {
    // MARK: Initializers
    private init() {}
}

// MARK:- Decoding
extension JSONDecoderService {
    public static func json(
        from data: Data
    ) -> Result<[String: Any], JSONDecodingError> {
        do {
            let jsonObject: Any = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            switch jsonObject as? [String: Any] {
            case let dictionary?: return .success(dictionary)
            case nil: return .failure(.failedToDecode(code: nil, description: nil))
            }
            
        } catch let error {
            return .failure(.failedToDecode(from: error))
        }
    }
    
    public static func entity<DecodedData: Decodable>(
        from data: Data
    ) -> Result<DecodedData, JSONDecodingError> {
        do {
            let data = try JSONDecoder().decode(DecodedData.self, from: data)
            return .success(data)
            
        } catch let error {
            return .failure(.failedToDecode(from: error))
        }
    }
    
    public static func image(
        from data: Data
    )  -> Result<UIImage, JSONDecodingError> {
        switch UIImage(data: data) {
        case let image?: return .success(image)
        case nil: return .failure(.failedToDecode(code: nil, description: nil))
        }
    }
}
