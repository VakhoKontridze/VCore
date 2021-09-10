//
//  JSONDecoderService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import UIKit

// MARK:- JSON Decoder Service
struct JSONDecoderService {
    // MARK: Initializers
    private init() {}
}

// MARK:- Decoding
extension JSONDecoderService {
    static func json(
        from data: Data
    ) -> Result<[String: Any], NetworkError> {
        do {
            let jsonObject: Any = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            switch jsonObject as? [String: Any] {
            case let dictionary?: return .success(dictionary)
            case nil: return .failure(.other())
            }
            
        } catch let error {
            return .failure(.other(from: error))
        }
    }
    
    static func entity<DecodedData: Decodable>(
        from data: Data
    ) -> Result<DecodedData, NetworkError> {
        do {
            let data = try JSONDecoder().decode(DecodedData.self, from: data)
            return .success(data)
            
        } catch let error {
            return .failure(.other(from: error))
        }
    }
    
    static func image(
        from data: Data
    )  -> Result<UIImage, NetworkError> {
        switch UIImage(data: data) {
        case let image?: return .success(image)
        case nil: return .failure(.other())
        }
    }
}
