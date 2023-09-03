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
        func networkClientErrorDescription(_ networkClientError: NetworkClientError.Code) -> String {
            "A"
        }
        
        func keychainServiceErrorDescription(_ keychainServiceError: VCore.KeychainServiceError.Code) -> String {
            "B"
        }
        
        var alertErrorTitle: String {
            "C"
        }
        
        var alertOKButtonTitle: String {
            "D"
        }
        
        var resultNoFailureErrorDescription: String {
            "E"
        }

        var responderChainToolBarDoneButtonTitle: String {
            "F"
        }
    }
    
    // MARK: Setup
    override class func setUp() {
        super.setUp()
        
        VCoreLocalizationManager.shared.localizationProvider = TestVCoreLocalizationProvider()
    }
    
    // MARK: Tests
    func testNetworkErrorDescription() async {
        do {
            try await NetworkClient.default.noData(from: NetworkRequest(url: ""))
            fatalError()
            
        } catch {
            XCTAssertEqual(
                error.localizedDescription,
                TestVCoreLocalizationProvider().networkClientErrorDescription(.invalidBody) // Code doesn't matter
            )
        }
    }
    
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
            UIAlertParameters(error: NetworkClientError.notConnectedToNetwork, completion: nil).title,
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
