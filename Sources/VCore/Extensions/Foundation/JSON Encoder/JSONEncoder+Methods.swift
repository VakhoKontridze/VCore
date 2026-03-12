//
//  JSONEncoder+Methods.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.09.23.
//

import Foundation

extension JSONEncoder {
    /// Encodes `Any` to `Data`.
    ///
    ///     let any: Any = ...
    ///     let data: Data = try JSONEncoder.encodeAnyToData(any)
    ///
    public static func encodeAnyToData(
        _ any: Any,
        optionsAnyToData options: JSONSerialization.WritingOptions = []
    ) throws -> Data {
        try JSONSerialization.data(withJSONObject: any, options: options)
    }

    /// Encodes `Encodable` to `JSON`.
    ///
    ///     let item: Item = ...
    ///     let json: [String: Any] = try JSONEncoder().encodeObjectToJSON(item)
    ///
    public func encodeObjectToJSON(
        _ object: some Encodable,
        optionsDataToJSONObject options: JSONSerialization.ReadingOptions = []
    ) throws -> [String: Any] {
        let data: Data = try encode(object)
        
        let json: [String: Any] = try JSONDecoder.decodeJSONFromData(
            data,
            optionsDataToJSONObject: options
        )

        return json
    }

    /// Encodes `Encodable` to `JSON` `Array`.
    ///
    ///     let items: [Item] = ...
    ///     let jsonArray: [[String: Any]] = try JSONEncoder().encodeObjectToJSONArray(items)
    ///
    public func encodeObjectToJSONArray(
        _ objects: some Encodable,
        optionsDataToJSONObject options: JSONSerialization.ReadingOptions = []
    ) throws -> [[String: Any]] {
        let data: Data = try encode(objects)

        let jsonArray: [[String: Any]] = try JSONDecoder.decodeJSONArrayFromData(
            data,
            optionsDataToJSONObject: options
        )

        return jsonArray
    }
}
