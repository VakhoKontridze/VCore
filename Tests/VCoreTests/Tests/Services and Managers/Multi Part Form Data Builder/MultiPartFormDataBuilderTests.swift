//
//  MultipartFormDataBuilderTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 15.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class MultipartFormDataBuilderTests: XCTestCase {
    // MARK: Test Data
    private let imagePrefix: String = "data:image/jpeg;base64,"

    @MemberwiseCodable
    private struct JSONPart: Encodable {
        @MWCKey("key") let key: String
    }

    // MARK: Tests
    func test() async throws {
        guard NetworkReachabilityService.shared.isConnectedToNetwork == true else {
            print("Not connected to network. Skipping \(String(describing: Self.self)).\(#function).")
            return
        }

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
        try request.addHTTPHeaderFields(object: MultipartFormDataAuthorizedRequestHeaderFields(
            boundary: boundary,
            token: "token"
        ))
        request.httpBody = httpData.nonEmpty

        let data: Data = try await URLSession.shared.data(for: request).0

        let result: [String: Any?] = try JSONDecoder.decodeJSONFromData(data)

        XCTAssertEqual(
            result["form"]?.toUnwrappedJSON["key"]?.toString,
            "value"
        )

#if canImport(UIKit)
        XCTAssertEqual(
            result["files"]?.toUnwrappedJSON["profile"]?.toString?.replacingOccurrences(of: imagePrefix, with: ""),
            profileImage?.jpegData(compressionQuality: 0.25)?.base64EncodedString()
        )

        XCTAssertEqual(
            result["files"]?.toUnwrappedJSON["gallery[0]"]?.toString?.replacingOccurrences(of: imagePrefix, with: ""),
            galleryImages?[0]?.jpegData(compressionQuality: 0.25)?.base64EncodedString()
        )

        XCTAssertEqual(
            result["files"]?.toUnwrappedJSON["gallery[1]"]?.toString?.replacingOccurrences(of: imagePrefix, with: ""),
            galleryImages?[1]?.jpegData(compressionQuality: 0.25)?.base64EncodedString()
        )
#endif
    }
}
