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
    /// Initializes `JSONDecoderService`.
    public init() {}

    // MARK: Decoding
    /// Decodes `Data` to `JSON`.
    public func json(
        data: Data
    ) throws -> [String: Any?] {
        let jsonObject: Any
        do {
            jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
        } catch let _error {
            let error: JSONDecoderError = .init(.failedToDecode)
            VCoreLog(error, _error)
            throw error
        }
        
        guard let json: [String: Any?] = jsonObject as? [String: Any?] else {
            let error: JSONDecoderError = .init(.failedToCast)
            VCoreLog(error)
            throw error
        }
        
        return json
    }
    
    /// Decodes `Data` to `JSON` `Array`.
    public func jsonArray(
        data: Data
    ) throws -> [[String: Any?]] {
        let jsonObject: Any
        do {
            jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
        } catch let _error {
            let error: JSONDecoderError = .init(.failedToDecode)
            VCoreLog(error, _error)
            throw error
        }
        
        guard let jsonArray: [[String: Any?]] = jsonObject as? [[String: Any?]] else {
            let error: JSONDecoderError = .init(.failedToCast)
            VCoreLog(error)
            throw error
        }

        return jsonArray
    }
    
    /// Decodes `Data` to `Decodable`.
    public func decodable<T>(
        data: Data
    ) throws -> T
        where T: Decodable
    {
        do {
            let decodable: T = try JSONDecoder().decode(T.self, from: data)
            return decodable
            
        } catch let _error {
            let error: JSONDecoderError = .init(.failedToDecode)
            VCoreLog(error, _error)
            throw error
        }
    }
    
    /// Decodes `JSON` to `Decodable`.
    public func decodable<T>(
        json: [String: Any?]
    ) throws -> T
        where T: Decodable
    {
        let data: Data
        do {
            data = try JSONSerialization.data(withJSONObject: json)
            
        } catch let _error {
            let error: JSONDecoderError = .init(.failedToEncode)
            VCoreLog(error, _error)
            throw error
        }
        
        let decodable: T
        do {
            decodable = try JSONDecoderService().decodable(data: data)
            
        } catch /*let _error*/ { // Logged internally
            let error: JSONDecoderError = .init(.failedToDecode)
            VCoreLog(error)
            throw error
        }
        
        return decodable
    }
    
    /// Decodes `JSON` `Array` to `Decodable`.
    public func decodable<T>(
        jsonArray: [[String: Any?]]
    ) throws -> T
        where T: Decodable
    {
        let data: Data
        do {
            data = try JSONSerialization.data(withJSONObject: jsonArray)
            
        } catch let _error {
            let error: JSONDecoderError = .init(.failedToEncode)
            VCoreLog(error, _error)
            throw error
        }
        
        let decodable: T
        do {
            decodable = try JSONDecoderService().decodable(data: data)
            
        } catch /*let _error*/ { // Logged internally
            let error: JSONDecoderError = .init(.failedToDecode)
            VCoreLog(error)
            throw error
        }
        
        return decodable
    }
}
