//
//  KeychainService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28/5/26.
//

public import Foundation

nonisolated public protocol KeychainService: Sendable {
    // MARK: Operations
    /// Returns `Data` associated with the key.
    func getData(
        key: String
    ) throws -> Data

    /// Sets `Data` with the key.
    func setData(
        key: String,
        value: Data
    ) throws

    /// Deletes `Data` associated with the key.
    func deleteData(
        key: String
    ) throws

    // MARK: Operations - Codable
    /// Returns `Codable` associated with the key.
    func getCodable<Value>(
        key: String
    ) throws -> Value
        where Value: Decodable

    /// Sets `Codable` with the key.
    func setCodable<Value>(
        key: String,
        value: Value
    ) throws
        where Value: Encodable

    /// Deletes `Codable` associated with the key.
    func deleteCodable(
        key: String
    ) throws

    // MARK: Subscript
    subscript(
        _ key: String
    ) -> Data? {
        get set
    }
}
