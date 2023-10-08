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
        var alertErrorTitle: String {
            "A"
        }
        
        var alertOKButtonTitle: String {
            "B"
        }

        var responderChainToolBarDoneButtonTitle: String {
            "C"
        }
    }
    
    // MARK: Setup
    override class func setUp() {
        super.setUp()
        
        VCoreLocalizationManager.shared.localizationProvider = TestVCoreLocalizationProvider()
    }
    
    // MARK: Tests    
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

#if canImport(UIKit) && !(os(tvOS) || os(watchOS))
    func testResponderChainToolBarDoneButtonTitle() {
        XCTAssertEqual(
            ResponderChainToolBar(size: CGSize.zero).doneButton.title,
            TestVCoreLocalizationProvider().responderChainToolBarDoneButtonTitle
        )
    }
#endif
}
