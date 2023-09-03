//
//  JSONDecoderMethods.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.09.23.
//

import Foundation

// MARK: - JSON Decoder Methods
extension JSONDecoder {
    /// Decodes top-level `JSON` from `Data`.
    ///
    ///     let data: Data = ...
    ///     let json: [String: Any?] = JSONDecoder.decodeJSONFromData(data)
    ///
    public func decodeJSONFromData(
        _ data: Data,
        optionsDataToJSONObject options: JSONSerialization.ReadingOptions = []
    ) throws -> [String: Any?] {
        let jsonObject: Any
        do {
            jsonObject = try JSONSerialization.jsonObject(with: data, options: options)

        } catch let error {
            VCoreLogError(error)
            throw error
        }

        guard let json = jsonObject as? [String: Any?] else {
            let error: CastingError = .init(from: "Data", to: "[String: Any?]")
            VCoreLogError(error)
            throw error
        }

        return json
    }

    /// Decodes top-level `JSON` `Array` from `Data`.
    ///
    ///     let data: Data = ...
    ///     let jsonArray: [[String: Any?]] = JSONDecoder.decodeJSONArrayFromData(data)
    ///
    public func decodeJSONArrayFromData(
        _ data: Data,
        optionsDataToJSONObject options: JSONSerialization.ReadingOptions = []
    ) throws -> [[String: Any?]] {
        let jsonObject: Any
        do {
            jsonObject = try JSONSerialization.jsonObject(with: data, options: options)

        } catch let error {
            VCoreLogError(error)
            throw error
        }

        guard let jsonArray = jsonObject as? [[String: Any?]] else {
            let error: CastingError = .init(from: "Data", to: "[[String: Any?]]")
            VCoreLogError(error)
            throw error
        }

        return jsonArray
    }

    /// Decodes top-level `JSON` from `Decodable`.
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
        let data: Data
        do {
            data = try JSONSerialization.data(withJSONObject: json, options: options)

        } catch let error {
            VCoreLogError(error)
            throw error
        }

        let object: T
        do {
            object = try decode(T.self, from: data)

        } catch let error {
            VCoreLogError(error)
            throw error
        }

        return object
    }
    /// Decodes top-level `JSON` `Array` from `Decodable`.
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
        let data: Data
        do {
            data = try JSONSerialization.data(withJSONObject: jsonArray, options: options)

        } catch let error {
            VCoreLogError(error)
            throw error
        }

        let object: T
        do {
            object = try decode(T.self, from: data)

        } catch let error {
            VCoreLogError(error)
            throw error
        }

        return object
    }
}
