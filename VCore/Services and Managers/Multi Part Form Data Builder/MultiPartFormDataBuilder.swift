//
//  MultiPartFormDataBuilder.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/20/21.
//

import Foundation

// MARK: - Multi Part Form Data Builder
/// Builder that builds boundary string and `Data` that can be send using network request.
///
/// Usage Example
///
///     Task(operation: {
///         let profileImage: UIImage? = nil        // Initialized elsewhere
///         let galleryImages: [UIImage?]? = nil    // Initialized elsewhere
///
///         let json: [String: Any?] = [
///             "first": "Vakhtang",
///             "last": "Kontridze"
///         ]
///
///         let files: [String: AnyMultiPartFormFile?] = [
///             "profile": MultiPartFormDataFile(
///                 mimeType: "image/jpeg",
///                 data: profileImage?.jpegData(compressionQuality: 0.75)
///             ),
///
///             "gallery": galleryImages?.compactMap { image in
///                 MultiPartFormDataFile(
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
///         do {
///             var request: NetworkRequest = .init(url: "https://somewebsite.com/api/some_endpoint")
///
///             request.method = .POST
///
///             try request.addHeaders([
///                 "Accept": "application/json",
///                 "Content-Type": "multipart/form-data; boundary=\(boundary)",
///                 "Authorization": "Bearer \("sometoken")"
///             ])
///
///             request.addBody(data)
///
///             let result: [String: Any?] = try await NetworkClient.default.json(from: request)
///
///             print(result)
///
///         } catch let error {
///             print(error.localizedDescription)
///         }
///     })
///
public struct MultiPartFormDataBuilder {
    // MARK: Properties
    private let json: [String: Any?]
    private let files: [String: AnyMultiPartFormFile?]
    
    static let lineBreak = "\r\n"
    
    // MARK: Initializers
    /// Initializes `MultiPartFormDataBuilder`.
    public init(
        json: [String: Any?],
        files: [String: AnyMultiPartFormFile?]
    ) {
        self.json = json
        self.files = files
    }
    
    // MARK: Building
    /// Builds and returns boundary string and `Data` that can be send using network request.
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
