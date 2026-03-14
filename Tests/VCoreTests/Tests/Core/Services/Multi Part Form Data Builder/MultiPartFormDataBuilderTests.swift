//
//  MultipartFormDataBuilderTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 15.05.22.
//

import SwiftUI
import Testing
@testable import VCore

// No need to cover `NSImage`

@Suite(
    .enabled(if: NetworkReachabilityService.shared.isConnectedToNetwork == true),
    .timeLimit(.minutes(1))
)
nonisolated struct MultipartFormDataBuilderTests {
    // MARK: Properties
    private let imagePrefix: String = "data:image/jpeg;base64,"

    // MARK: Tests
    @Test
    func test() async throws {
#if canImport(UIKit)
        let profileImage: UIImage? = .init(size: CGSize(dimension: 100), color: UIColor.red)

        let galleryImages: [UIImage?]? = [
            .init(size: CGSize(dimension: 100), color: UIColor.green),
            .init(size: CGSize(dimension: 100), color: UIColor.blue)
        ]
#endif

        let jsonObject: JSONPart = .init(
            key: "value"
        )

#if canImport(UIKit)
        let files: [String: (some AnyMultipartFormDataFile)?] = [
            "profile": MultipartFormDataFile(
                mimeType: "image/jpeg",
                data: profileImage?.jpegData(compressionQuality: 0.25)
            ),

            "gallery": galleryImages?.enumerated().compactMap { (index, image) in
                MultipartFormDataFile(
                    filename: "IMG_\(index).jpg",
                    mimeType: "image/jpeg",
                    data: image?.jpegData(compressionQuality: 0.25)
                )
            }
        ]
#else
        let files: [String: (any AnyMultipartFormDataFile)?] = [:]
#endif

        let (boundary, httpData): (String, Data) = try MultipartFormDataBuilder().build(
            object: jsonObject,
            files: files
        )

        let url: URL = #url("https://httpbin.org/post")

        var request: URLRequest = .init(url: url)
        request.httpMethod = "POST"
        try request.addHTTPHeaderFields(
            object: MultipartFormDataAuthorizedRequestHeaderFields(
                boundary: boundary,
                token: "token"
            )
        )
        request.httpBody = httpData.nonEmpty

        let data: Data = try await URLSession.shared.data(for: request).0

        let result: [String: Any] = try JSONDecoder.decodeJSONFromData(data)

        #expect(
            (result["form"] as? [String: Any])?["key"] as? String ==
            "value"
        )

#if canImport(UIKit)
        #expect(
            ((result["files"] as? [String: Any])?["profile"] as? String)?.replacingOccurrences(of: imagePrefix, with: "") ==
            profileImage?.jpegData(compressionQuality: 0.25)?.base64EncodedString()
        )

        #expect(
            ((result["files"] as? [String: Any])?["gallery[0]"] as? String)?.replacingOccurrences(of: imagePrefix, with: "") ==
            galleryImages?[0]?.jpegData(compressionQuality: 0.25)?.base64EncodedString()
        )

        #expect(
            ((result["files"] as? [String: Any])?["gallery[1]"] as? String)?.replacingOccurrences(of: imagePrefix, with: "") ==
            galleryImages?[1]?.jpegData(compressionQuality: 0.25)?.base64EncodedString()
        )
#endif
    }
    
    // MARK: Types
    @CodingKeysGeneration
    nonisolated private struct JSONPart: Encodable {
        @CKGProperty("key") let key: String
    }
}
