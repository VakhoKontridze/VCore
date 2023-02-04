//
//  JSONDecoderService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK: - JSON Decoder Service
/// Object that decodes instances of data types.
///
///     do {
///         let json: [String: Any?] = try JSONDecoderService().json(data: data)
///         ...
///
///     } catch {
///         ...
///     }
///
public struct JSONDecoderService {
    // MARK: Initializers
    /// Initializes `JSONDecoderService`.
    public init() {}

    // MARK: Decoding
    /// Decodes `Data` to `JSON`.
    public func json(
        data: Data,
        options: JSONSerialization.ReadingOptions = []
    ) throws -> [String: Any?] {
        let jsonObject: Any
        do {
            jsonObject = try JSONSerialization.jsonObject(with: data, options: options)
            
        } catch let _error {
            let error: JSONDecoderError = .init(.failedToDecode)
            VCoreLogError(error, _error)
            throw error
        }
        
        guard let json: [String: Any?] = jsonObject as? [String: Any?] else {
            let error: JSONDecoderError = .init(.failedToCast)
            VCoreLogError(error)
            throw error
        }
        
        return json
    }
    
    /// Decodes `Data` to `JSON` `Array`.
    public func jsonArray(
        data: Data,
        options: JSONSerialization.ReadingOptions = []
    ) throws -> [[String: Any?]] {
        let jsonObject: Any
        do {
            jsonObject = try JSONSerialization.jsonObject(with: data, options: options)
            
        } catch let _error {
            let error: JSONDecoderError = .init(.failedToDecode)
            VCoreLogError(error, _error)
            throw error
        }
        
        guard let jsonArray: [[String: Any?]] = jsonObject as? [[String: Any?]] else {
            let error: JSONDecoderError = .init(.failedToCast)
            VCoreLogError(error)
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
            VCoreLogError(error, _error)
            throw error
        }
    }
    
    /// Decodes `JSON` to `Decodable`.
    public func decodable<T>(
        json: [String: Any?],
        options: JSONSerialization.WritingOptions = []
    ) throws -> T
        where T: Decodable
    {
        let data: Data
        do {
            data = try JSONSerialization.data(withJSONObject: json, options: options)
            
        } catch let _error {
            let error: JSONDecoderError = .init(.failedToEncode)
            VCoreLogError(error, _error)
            throw error
        }
        
        let decodable: T
        do {
            decodable = try JSONDecoderService().decodable(data: data)
            
        } catch /*let _error*/ { // Logged internally
            let error: JSONDecoderError = .init(.failedToDecode)
            VCoreLogError(error)
            throw error
        }
        
        return decodable
    }
    
    /// Decodes `JSON` `Array` to `Decodable`.
    public func decodable<T>(
        jsonArray: [[String: Any?]],
        options: JSONSerialization.WritingOptions = []
    ) throws -> T
        where T: Decodable
    {
        let data: Data
        do {
            data = try JSONSerialization.data(withJSONObject: jsonArray, options: options)
            
        } catch let _error {
            let error: JSONDecoderError = .init(.failedToEncode)
            VCoreLogError(error, _error)
            throw error
        }
        
        let decodable: T
        do {
            decodable = try JSONDecoderService().decodable(data: data)
            
        } catch /*let _error*/ { // Logged internally
            let error: JSONDecoderError = .init(.failedToDecode)
            VCoreLogError(error)
            throw error
        }
        
        return decodable
    }
}
