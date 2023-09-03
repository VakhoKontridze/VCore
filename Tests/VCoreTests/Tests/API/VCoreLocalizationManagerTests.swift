//
//  VCoreLocalizationManagerTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 17.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class VCoreLocalizationManagerTests: XCTestCase {
    // MARK: Test Data
    private struct TestVCoreLocalizationProvider: VCoreLocalizationProvider {
        func keychainServiceErrorDescription(_ keychainServiceError: VCore.KeychainServiceError.Code) -> String {
            "A"
        }
        
        var alertErrorTitle: String {
            "B"
        }
        
        var alertOKButtonTitle: String {
            "C"
        }
        
        var resultNoFailureErrorDescription: String {
            "D"
        }

        var responderChainToolBarDoneButtonTitle: String {
            "E"
        }
    }
    
    // MARK: Setup
    override class func setUp() {
        super.setUp()
        
        VCoreLocalizationManager.shared.localizationProvider = TestVCoreLocalizationProvider()
    }
    
    // MARK: Tests
    func testKeychainServiceErrorDescription() {
        XCTAssertThrowsError(
            try KeychainService.default.get(key: "N/A"),
            "",
            { error in
                XCTAssertEqual(
                    error.localizedDescription,
                    TestVCoreLocalizationProvider().keychainServiceErrorDescription(.failedToGet) // Code doesn't matter
                )
            }
        )
    }
    
#if canImport(UIKit) && !os(watchOS)
    func testAlertErrorTitle() {
        XCTAssertEqual(
            UIAlertParameters(error: URLError(.notConnectedToInternet), completion: nil).title,
            TestVCoreLocalizationProvider().alertErrorTitle
        )
    }
#endif
    
#if canImport(UIKit) && !os(watchOS)
    func testAlertOkButtonTitle() {
        XCTAssertEqual(
            (UIAlertParameters(title: "T", message: "M", completion: nil).buttons().first! as! UIAlertButton).title,
            TestVCoreLocalizationProvider().alertOKButtonTitle
        )
    }
#endif
    
    func testResultNoFailureErrorDescription() {
        XCTAssertThrowsError(
            try ResultNoFailure<Any>.failure.get(),
            "",
            { error in
                XCTAssertEqual(
                    error.localizedDescription,
                    TestVCoreLocalizationProvider().resultNoFailureErrorDescription
                )
            }
        )
    }

#if os(iOS) || targetEnvironment(macCatalyst)
    func testResponderChainToolBarDoneButtonTitle() {
        XCTAssertEqual(
            ResponderChainToolBar(size: CGSize.zero).doneButton.title,
            TestVCoreLocalizationProvider().responderChainToolBarDoneButtonTitle
        )
    }
#endif
}
