//
//  JSONEncoderService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK: - JSON Encoder Service
/// Object that encodes instances of data types.
///
///     struct SomeObject: Encodable {
///         let value: Int?
///     }
///
///     do {
///         let someObject: SomeObject = .init(value: 10)
///         let data: Data = try JSONEncoderService().data(encodable: someObject)
///         ...
///
///     } catch {
///         ...
///     }
///
public struct JSONEncoderService {
    // MARK: Initializers
    /// Initializes `JSONEncoderService`.
    public init() {}
    
    // MARK: Encoding
    /// Encodes `Any` to `Data`.
    public func data(
        any: Any?,
        options: JSONSerialization.WritingOptions = []
    ) throws -> Data {
        guard let any else {
            let error: JSONEncoderError = .init(.failedToCast)
            VCoreLogError(error)
            throw error
        }
        
        let data: Data
        do {
            data = try JSONSerialization.data(withJSONObject: any, options: options)
            
        } catch let _error {
            let error: JSONEncoderError = .init(.failedToEncode)
            VCoreLogError(error, _error)
            throw error
        }
        
        return data
    }
    
    /// Encodes `Encodable` to `Data`.
    public func data(
        encodable: some Encodable
    ) throws -> Data {
        do {
            let data: Data = try JSONEncoder().encode(encodable)
            return data
            
        } catch let _error {
            let error: JSONEncoderError = .init(.failedToEncode)
            VCoreLogError(error, _error)
            throw error
        }
    }
    
    /// Encodes `Encodable` to `JSON`.
    public func json(
        encodable: some Encodable,
        optionsDataToJSON: JSONSerialization.ReadingOptions = []
    ) throws -> [String: Any?] {
        let data: Data
        do {
            data = try JSONEncoder().encode(encodable)
            
        } catch let _error {
            let error: JSONEncoderError = .init(.failedToEncode)
            VCoreLogError(error, _error)
            throw error
        }
        
        let json: [String: Any?]
        do {
            json = try JSONDecoderService().json(data: data, options: optionsDataToJSON)
            
        } catch /*let _error*/ { // Logged internally
            let error: JSONEncoderError = .init(.failedToDecode)
            VCoreLogError(error)
            throw error
        }
        
        return json
    }
    
    /// Encodes `Encodable` to `JSON` `Array`.
    public func jsonArray(
        encodable: some Encodable,
        optionsDataToJSONArray: JSONSerialization.ReadingOptions = []
    ) throws -> [[String: Any?]] {
        let data: Data
        do {
            data = try JSONEncoder().encode(encodable)
            
        } catch let _error {
            let error: JSONEncoderError = .init(.failedToEncode)
            VCoreLogError(error, _error)
            throw error
        }
        
        let jsonArray: [[String: Any?]]
        do {
            jsonArray = try JSONDecoderService().jsonArray(data: data, options: optionsDataToJSONArray)
            
        } catch /*let _error*/ { // Logged internally
            let error: JSONEncoderError = .init(.failedToDecode)
            VCoreLogError(error)
            throw error
        }
        
        return jsonArray
    }
}
