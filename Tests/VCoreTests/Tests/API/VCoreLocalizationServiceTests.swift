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
        func networkClientErrorDescription(_ networkClientError: NetworkClientError.ErrorCode) -> String {
            "A"
        }
        
        func jsonEncoderErrorDescription(_ jsonEncoderError: JSONEncoderError.ErrorCode) -> String {
            "B"
        }
        
        func jsonDecoderErrorDescription(_ jsonDecoderError: JSONDecoderError.ErrorCode) -> String {
            "C"
        }
        
        func keychainServiceErrorDescription(_ keychainServiceError: VCore.KeychainServiceError.ErrorCode) -> String {
            "D"
        }
        
        var alertErrorTitle: String {
            "E"
        }
        
        var alertOKButtonTitle: String {
            "F"
        }
        
        var resultNoFailureErrorDescription: String {
            "G"
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
            try JSONEncoderService().data(any: nil),
            "",
            { error in XCTAssertEqual(error.localizedDescription, "B") }
        )
    }
    
    func testJSONDecoderErrorDescription() {
        XCTAssertThrowsError(
            try JSONDecoderService().json(data: .init()),
            "",
            { error in XCTAssertEqual(error.localizedDescription, "C") }
        )
    }
    
    func testKeychainServiceErrorDescription() {
        XCTAssertThrowsError(
            try KeychainService.get(key: "N/A"),
            "",
            { error in XCTAssertEqual(error.localizedDescription, "D") }
        )
    }
    
    #if canImport(UIKit) && !os(watchOS)
    func testAlertErrorTitle() {
        XCTAssertEqual(
            UIAlertParameters(error: NetworkClientError.notConnectedToNetwork, completion: nil).title,
            "E"
        )
    }
    #endif
    
    #if canImport(UIKit) && !os(watchOS)
    func testAlertOkButtonTitle() {
        XCTAssertEqual(
            (UIAlertParameters(title: "T", message: "M", completion: nil).buttons().first! as! UIAlertButton).title,
            "F"
        )
    }
    #endif
    
    func testResultNoFailureErrorDescription() {
        XCTAssertThrowsError(
            try ResultNoFailure<Any>.failure.get(),
            "",
            { error in XCTAssertEqual(error.localizedDescription, "G") }
        )
    }
}
