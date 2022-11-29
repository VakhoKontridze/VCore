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
    
    private struct JSONPart: Encodable {
        let key: String
        
        private enum CodingKeys: String, CodingKey {
            case key = "key"
        }
    }
    
    // MARK: Tests
    func test() async {
        guard NetworkReachabilityService.shared.isConnectedToNetwork != false else {
            print("Not connected to network. Skipping \(String(describing: Self.self)).\(#function).")
            return
        }
        
        #if canImport(UIKit)
        
        let profileImage: UIImage? = .init(size: .init(dimension: 100), color: .red)
        
        let galleryImages: [UIImage?]? = [
            .init(size: .init(dimension: 100), color: .green),
            .init(size: .init(dimension: 100), color: .blue)
        ]
        
        #endif
        
        do {
            let json: JSONPart = .init(
                key: "value"
            )
            
            #if canImport(UIKit)
            
            let files: [String: (some AnyMultiPartFormDataFile)?] = [
                "profile": MultiPartFormDataFile(
                    mimeType: "image/jpeg",
                    data: profileImage?.jpegData(compressionQuality: 0.25)
                ),
                
                "gallery": galleryImages?.enumerated().compactMap { (index, image) in
                    MultiPartFormDataFile(
                        filename: "IMG_\(index).jpg",
                        mimeType: "image/jpeg",
                        data: image?.jpegData(compressionQuality: 0.25)
                    )
                }
            ]
            
            #else
            
            let files: [String: (any AnyMultiPartFormDataFile)?] = [:]
            
            #endif
            
            let (boundary, data): (String, Data) = try MultiPartFormDataBuilder().build(
                encodable: json,
                files: files
            )
            
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
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
