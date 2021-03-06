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
    // MARK: Test Data
    private let imagePrefix: String = "data:image/jpeg;base64,"
    
    // MARK: Tests
    func test() async {
        guard NetworkReachabilityService.shared.isConnectedToNetwork else { return }
        
        #if canImport(UIKit)
        
        let profileImage: UIImage? = .init(size: .init(dimension: 100), color: .red)
        
        let galleryImages: [UIImage?]? = [
            .init(size: .init(dimension: 100), color: .green),
            .init(size: .init(dimension: 100), color: .blue)
        ]
        
        do {
            let json: [String: Any?] = [
                "key": "value"
            ]

            let files: [String: (any AnyMultiPartFormDataFile)?] = [
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
            
            let (boundary, data): (String, Data) = MultiPartFormDataBuilder(
                json: json,
                files: files
            ).build()

            var request: NetworkRequest = .init(url: "https://httpbin.org/post")

            request.method = .POST

            try request.addHeaders(encodable: MultiPartFormDataAuthorizedRequestHeaders(
                boundary: boundary,
                token: "token"
            ))

            request.addBody(data: data)

            let result: [String: Any?] = try await NetworkClient.default.json(from: request)

            XCTAssertEqual(
                result["form"]?.toUnwrappedJSON["key"]?.toString,
                "value"
            )
            
            XCTAssertEqual(
                result["files"]?.toUnwrappedJSON["profile"]?.toString?.replacingOccurrences(of: imagePrefix, with: ""),
                profileImage?.jpegData(compressionQuality: 0.75)?.base64EncodedString()
            )
            
            XCTAssertEqual(
                result["files"]?.toUnwrappedJSON["gallery[0]"]?.toString?.replacingOccurrences(of: imagePrefix, with: ""),
                galleryImages?[0]?.jpegData(compressionQuality: 0.75)?.base64EncodedString()
            )
            
            XCTAssertEqual(
                result["files"]?.toUnwrappedJSON["gallery[1]"]?.toString?.replacingOccurrences(of: imagePrefix, with: ""),
                galleryImages?[1]?.jpegData(compressionQuality: 0.75)?.base64EncodedString()
            )
            
        } catch {
            fatalError(error.localizedDescription)
        }
        
        #else
        
        do {
            let json: [String: Any?] = [
                "key": "value"
            ]

            let files: [String: (any AnyMultiPartFormDataFile)?] = [:]
            
            let (boundary, data): (String, Data) = MultiPartFormDataBuilder(
                json: json,
                files: files
            ).build()

            var request: NetworkRequest = .init(url: "https://httpbin.org/post")

            request.method = .POST

            try request.addHeaders(encodable: MultiPartFormDataAuthorizedRequestHeaders(
                boundary: boundary,
                token: "token"
            ))

            request.addBody(data: data)

            let result: [String: Any?] = try await NetworkClient.default.json(from: request)

            XCTAssertEqual(
                result["form"]?.toUnwrappedJSON["key"]?.toString,
                "value"
            )
            
        } catch {
            fatalError(error.localizedDescription)
        }
        
        #endif
    }
}
