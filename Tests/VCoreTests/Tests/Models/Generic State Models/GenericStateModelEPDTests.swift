//
//  GenericStateModelEPDTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class GenericStateModelEPDTests: XCTestCase {
    func testInitValue() {
        #if canImport(UIKit)
        
        let value: UIColor = .red
        
        let model: GenericStateModel_EPD = .init(value)
        
        XCTAssertEqualColor(model.enabled, value)
        XCTAssertEqualColor(model.disabled, value)
        XCTAssertEqualColor(model.disabled, value)
    
        #elseif canImport(AppKit)
        
        let value: NSColor = .red
        
        let model: GenericStateModel_EPD = .init(value)
        
        XCTAssertEqualColor(model.enabled, value)
        XCTAssertEqualColor(model.disabled, value)
        XCTAssertEqualColor(model.disabled, value)
        
        #endif
    }
}
