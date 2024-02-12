//
//  JSONDecoder.Methods.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.09.23.
//

import Foundation

// MARK: - JSON Decoder Methods
extension JSONDecoder {
    /// Decodes `JSON` from `Data`.
    ///
    ///     let data: Data = ...
    ///     let json: [String: Any?] = JSONDecoder.decodeJSONFromData(data)
    ///
    public static func decodeJSONFromData(
        _ data: Data,
        optionsDataToJSONObject options: JSONSerialization.ReadingOptions = []
    ) throws -> [String: Any?] {
        let jsonObject: Any = try JSONSerialization.jsonObject(with: data, options: options)

        guard let json = jsonObject as? [String: Any?] else {
            throw CastingError(from: "Any", to: "[String: Any?]")
        }

        return json
    }

    /// Decodes `JSON` `Array` from `Data`.
    ///
    ///     let data: Data = ...
    ///     let jsonArray: [[String: Any?]] = JSONDecoder.decodeJSONArrayFromData(data)
    ///
    public static func decodeJSONArrayFromData(
        _ data: Data,
        optionsDataToJSONObject options: JSONSerialization.ReadingOptions = []
    ) throws -> [[String: Any?]] {
        let jsonObject: Any = try JSONSerialization.jsonObject(with: data, options: options)

        guard let jsonArray = jsonObject as? [[String: Any?]] else {
            throw CastingError(from: "Any", to: "[[String: Any?]]")
        }

        return jsonArray
    }

    /// Decodes `Decodable` from `JSON`.
    ///
    ///     let json: [String: Any?] = ...
    ///     let object: SomeObject = JSONDecoder().decodeObjectFromJSON(json)
    ///
    public func decodeObjectFromJSON<T>(
        _ json: [String: Any?],
        optionsJSONToData options: JSONSerialization.WritingOptions = []
    ) throws -> T
        where T: Decodable
    {
        let data: Data = try JSONSerialization.data(withJSONObject: json, options: options)

        let object: T = try decode(T.self, from: data)

        return object
    }
    /// Decodes `Decodable` from `JSON` `Array`.
    ///
    ///     let jsonArray: [[String: Any?]] = ...
    ///     let object: SomeObject = JSONDecoder().decodeObjectFromJSONArray(jsonArray)
    ///
    public func decodeObjectFromJSONArray<T>(
        _ jsonArray: [[String: Any?]],
        optionsJSONArrayToData options: JSONSerialization.WritingOptions = []
    ) throws -> T
        where T: Decodable
    {
        let data: Data = try JSONSerialization.data(withJSONObject: jsonArray, options: options)

        let object: T = try decode(T.self, from: data)

        return object
    }
}
