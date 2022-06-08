//
//  VCoreLocalizationServiceTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 17.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class VCoreLocalizationServiceTests: XCTestCase {
    // MARK: Test Data
    private struct TestVCoreLocalizationProvider: VCoreLocalizationProvider {
        func networkErrorDescription(_ networkError: NetworkError) -> String {
            "A"
        }
        
        func jsonEncoderErrorDescription(_ jsonEncoderError: JSONEncoderError) -> String {
            "B"
        }
        
        func jsonDecoderErrorDescription(_ jsonDecoderError: JSONDecoderError) -> String {
            "C"
        }
    }
    
    // MARK: Setup
    override class func setUp() {
        super.setUp()
        
        VCoreLocalizationService.shared.localizationProvider = TestVCoreLocalizationProvider()
    }
    
    // MARK: Tests
    func testNetworkError() async {
        do {
            try await NetworkClient.default.noData(from: .init(url: ""))
            fatalError()
            
        } catch {
            XCTAssertEqual(error.localizedDescription, "A")
        }
    }

    func testJSONEncoderError() {
        XCTAssertThrowsError(
            try JSONEncoderService.data(any: nil),
            "",
            { error in XCTAssertEqual(error.localizedDescription, "B") }
        )
    }
    
    func testJSONDecoderError() {
        XCTAssertThrowsError(
            try JSONDecoderService.json(data: .init()),
            "",
            { error in XCTAssertEqual(error.localizedDescription, "C") }
        )
    }
}
