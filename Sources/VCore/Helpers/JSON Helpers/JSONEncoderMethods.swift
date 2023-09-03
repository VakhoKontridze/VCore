//
//  JSONEncoderMethods.swift
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
    ///     let data: Data = try JSONEncoder().encodeAnyToData(any)
    ///
    public func encodeAnyToData(
        _ any: Any?,
        optionsAnyToData options: JSONSerialization.WritingOptions = []
    ) throws -> Data {
        guard let any else {
            let error: CastingError = .init(from: "Any?", to: "Any")
            VCoreLogError(error)
            throw error
        }

        let data: Data
        do {
            data = try JSONSerialization.data(withJSONObject: any, options: options)

        } catch let error {
            VCoreLogError(error)
            throw error
        }

        return data
    }

    /// Encodes `Encodable` to `JSON`.
    ///
    ///     let object: SomeObject = ...
    ///     let json: [String: Any?] = try JSONEncoder().encodeObjectToJSON(object)
    ///
    public func encodeObjectToJSON(
        _ object: some Encodable,
        optionsDataToJSONObject options: JSONSerialization.ReadingOptions = [],
        decoderDataToJSON decoder: JSONDecoder = .init()
    ) throws -> [String: Any?] {
        let data: Data
        do {
            data = try encode(object)

        } catch let error {
            VCoreLogError(error)
            throw error
        }

        let json: [String: Any?]
        do {
            json = try decoder.decodeJSONFromData(
                data,
                optionsDataToJSONObject: options
            )

        } catch /*let error*/ { // Logged internally
            throw error
        }

        return json
    }

    /// Encodes `Encodable` to `JSON` `Array`.
    ///
    ///     let objects: [SomeObject] = ...
    ///     let jsonArray: [[String: Any?]] = try JSONEncoder().encodeObjectToJSONArray(objects)
    ///
    public func encodeObjectToJSONArray(
        _ objects: some Encodable,
        optionsDataToJSONObject options: JSONSerialization.ReadingOptions = [],
        decoderDataToJSONArray decoder: JSONDecoder = .init()
    ) throws -> [[String: Any?]] {
        let data: Data
        do {
            data = try encode(objects)

        } catch let error {
            VCoreLogError(error)
            throw error
        }

        let jsonArray: [[String: Any?]]
        do {
            jsonArray = try decoder.decodeJSONArrayFromData(
                data,
                optionsDataToJSONObject: options
            )

        } catch /*let error*/ { // Logged internally
            throw error
        }

        return jsonArray
    }
}
