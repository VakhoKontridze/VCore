//
//  JSONEncoder.Methods.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.09.23.
//

import Foundation

// MARK: - JSON Encoder Methods
extension JSONEncoder {
    /// Encodes `Any?` to `Data`.
    ///
    ///     let any: Any? = ...
    ///     let data: Data = try JSONEncoder.encodeAnyToData(any)
    ///
    public static func encodeAnyToData(
        _ any: Any?,
        optionsAnyToData options: JSONSerialization.WritingOptions = []
    ) throws -> Data {
        guard let any else {
            throw CastingError(from: "Any?", to: "Any")
        }

        let data: Data = try JSONSerialization.data(withJSONObject: any, options: options)

        return data
    }

    /// Encodes `Encodable` to `JSON`.
    ///
    ///     let object: SomeObject = ...
    ///     let json: [String: Any?] = try JSONEncoder().encodeObjectToJSON(object)
    ///
    public func encodeObjectToJSON(
        _ object: some Encodable,
        optionsDataToJSONObject options: JSONSerialization.ReadingOptions = []
    ) throws -> [String: Any?] {
        let data: Data = try encode(object)
        
        let json: [String: Any?] = try JSONDecoder.decodeJSONFromData(
            data,
            optionsDataToJSONObject: options
        )

        return json
    }

    /// Encodes `Encodable` to `JSON` `Array`.
    ///
    ///     let objects: [SomeObject] = ...
    ///     let jsonArray: [[String: Any?]] = try JSONEncoder().encodeObjectToJSONArray(objects)
    ///
    public func encodeObjectToJSONArray(
        _ objects: some Encodable,
        optionsDataToJSONObject options: JSONSerialization.ReadingOptions = []
    ) throws -> [[String: Any?]] {
        let data: Data = try encode(objects)

        let jsonArray: [[String: Any?]] = try JSONDecoder.decodeJSONArrayFromData(
            data,
            optionsDataToJSONObject: options
        )

        return jsonArray
    }
}
