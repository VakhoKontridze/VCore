//
//  MultiPartFormDataBuilder.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/20/21.
//

import Foundation

// MARK: - Multi Part Form Data Builder
/// Builder that generates boundary `String` and generated `Data` for network requests.
///
///     do {
///         let json: [String: Any?] = [
///             "key": "value"
///         ]
///
///         let files: [String: AnyMultiPartFormDataFile?] = [
///             "profile": MultiPartFormDataFile(
///                 mimeType: "image/jpeg",
///                 data: profileImage?.jpegData(compressionQuality: 0.75)
///             ),
///
///             "gallery": galleryImages?.enumerated().compactMap { (index, image) in
///                 MultiPartFormDataFile(
///                     filename: "IMG_\(index).jpg",
///                     mimeType: "image/jpeg",
///                     data: image?.jpegData(compressionQuality: 0.75)
///                 )
///             }
///         ]
///
///         let (boundary, data): (String, Data) = MultiPartFormDataBuilder(
///             json: json,
///             files: files
///         ).build()
///
///         var request: NetworkRequest = .init(url: "https://somewebsite.com/api/some_endpoint")
///
///         request.method = .POST
///
///         try request.addHeaders(encodable: MultiPartFormDataAuthorizedRequestHeaders(
///             boundary: boundary,
///             token: "token"
///         ))
///
///         request.addBody(data: data)
///
///         let result: [String: Any?] = try await NetworkClient.default.json(from: request)
///
///         print(result)
///
///     } catch {
///         print(error.localizedDescription)
///     }
///
public struct MultiPartFormDataBuilder {
    // MARK: Properties
    private let json: [String: Any?]
    private let files: [String: AnyMultiPartFormDataFile?]
    
    static let lineBreak = "\r\n"
    
    // MARK: Initializers
    /// Initializes `MultiPartFormDataBuilder`.
    public init(
        json: [String: Any?],
        files: [String: AnyMultiPartFormDataFile?]
    ) {
        self.json = json
        self.files = files
    }
    
    // MARK: Building
    /// Builds and returns boundary string and `Data` that can be sent using network request.
    public func build() -> (String, Data) {
        let boundary: String = buildBoundary()
        let data: Data = buildData(boundary: boundary)
        
        return (boundary, data)
    }

    private func buildBoundary() -> String {
        UUID().uuidString
    }
    
    private func buildData(boundary: String) -> Data {
        var data: Data = .init()
        data.append(JSONBuilder(boundary: boundary, json: json).build())
        data.append(FileBuilder(boundary: boundary, files: files).build())
        data.append("--\(boundary)--\(Self.lineBreak)")
        return data
    }
}

// MARK: - Helpers
extension Data {
    mutating func append(_ value: String) {
        guard let data: Data = value.data(using: .utf8) else { return }
        append(data)
    }
}
