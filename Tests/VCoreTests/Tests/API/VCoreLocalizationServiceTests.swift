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
        
        var alertErrorTitle: String {
            "D"
        }
        
        var alertOKButtonTitle: String {
            "E"
        }
        
        var resultNoFailureErrorDescription: String {
            "F"
        }
    }
    
    // MARK: Setup
    override class func setUp() {
        super.setUp()
        
        VCoreLocalizationService.shared.localizationProvider = TestVCoreLocalizationProvider()
    }
    
    // MARK: Tests
    func testNetworkErrorDescription() async {
        do {
            try await NetworkClient.default.noData(from: .init(url: ""))
            fatalError()
            
        } catch {
            XCTAssertEqual(error.localizedDescription, "A")
        }
    }

    func testJSONEncoderErrorDescription() {
        XCTAssertThrowsError(
            try JSONEncoderService.data(any: nil),
            "",
            { error in XCTAssertEqual(error.localizedDescription, "B") }
        )
    }
    
    func testJSONDecoderErrorDescription() {
        XCTAssertThrowsError(
            try JSONDecoderService.json(data: .init()),
            "",
            { error in XCTAssertEqual(error.localizedDescription, "C") }
        )
    }
    
    #if canImport(UIKit) && !os(watchOS)
    func testAlertErrorTitle() {
        XCTAssertEqual(
            UIAlertViewModel(error: NetworkError.notConnectedToNetwork, completion: nil).title,
            "D"
        )
    }
    #endif
    
    #if canImport(UIKit) && !os(watchOS)
    func testAlertOkButtonTitle() {
        XCTAssertEqual(
            UIAlertViewModel(title: "T", message: "M", completion: nil).buttons.first!.title,
            "E"
        )
    }
    #endif
    
    func testResultNoFailureErrorDescription() {
        XCTAssertThrowsError(
            try ResultNoFailure<Any>.failure.get(),
            "",
            { error in XCTAssertEqual(error.localizedDescription, "F") }
        )
    }
}
