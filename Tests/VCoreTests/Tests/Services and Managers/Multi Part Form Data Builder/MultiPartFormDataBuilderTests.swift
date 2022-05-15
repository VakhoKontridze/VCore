//
//  MultiPartFormDataBuilderTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 15.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class MultiPartFormDataBuilderTests: XCTestCase {
    private let imagePrefix: String = "data:image/jpeg;base64,"
    
    func test() async {
        guard NetworkReachabilityService.isConnectedToNetwork else { return }
        
        let profileImage: UIImage? = .init(size: .init(dimension: 100), color: .red)
        
        let galleryImages: [UIImage?]? = [
            .init(size: .init(dimension: 100), color: .green),
            .init(size: .init(dimension: 100), color: .blue)
        ]
        
        do {
            let json: [String: Any?] = [
                "someKey": "someValue"
            ]

            let files: [String: AnyMultiPartFormFile?] = [
                "profile": MultiPartFormDataFile(
                    mimeType: "image/jpeg",
                    data: profileImage?.jpegData(compressionQuality: 0.75)
                ),

                "gallery": galleryImages?.enumerated().compactMap { (index, image) in
                    MultiPartFormDataFile(
                        filename: "IMG_\(index).jpg",
                        mimeType: "image/jpeg",
                        data: image?.jpegData(compressionQuality: 0.75)
                    )
                }
            ]
            
            let (boundary, data): (String, Data) = try MultiPartFormDataBuilder(
                json: json,
                files: files
            ).build()

            var request: NetworkRequest = .init(url: "https://httpbin.org/post")

            request.method = .POST

            try request.addHeaders(encodable: MultiPartFormDataAuthorizedRequestHeaders(
                boundary: boundary,
                token: "sometoken"
            ))

            request.addBody(data: data)

            let result: [String: Any?] = try await NetworkClient.default.json(from: request)

            XCTAssertEqual(
                result["form"]?.toJSON?["someKey"]?.toString,
                "someValue"
            )
            
            XCTAssertEqual(
                result["files"]?.toJSON?["profile"]?.toString?.replacingOccurrences(of: imagePrefix, with: ""),
                profileImage?.jpegData(compressionQuality: 0.75)?.base64EncodedString()
            )
            
            XCTAssertEqual(
                result["files"]?.toJSON?["gallery[0]"]?.toString?.replacingOccurrences(of: imagePrefix, with: ""),
                galleryImages?[0]?.jpegData(compressionQuality: 0.75)?.base64EncodedString()
            )
            
            XCTAssertEqual(
                result["files"]?.toJSON?["gallery[1]"]?.toString?.replacingOccurrences(of: imagePrefix, with: ""),
                galleryImages?[1]?.jpegData(compressionQuality: 0.75)?.base64EncodedString()
            )
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
