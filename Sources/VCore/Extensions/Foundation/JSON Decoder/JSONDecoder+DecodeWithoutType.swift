//
//  JSONDecoder+DecodeWithoutType.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/3/26.
//

import Foundation

nonisolated extension JSONDecoder {
    /// Decodes a top-level value of the given type from the given JSON representation.
    ///
    ///     let object: SomeObject = try JSONDecoder().decode(from: data)
    ///
    public func decode<T>(from data: Data) throws -> T where T: Decodable {
        try decode(T.self, from: data)
    }
}
