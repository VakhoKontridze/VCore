//
//  SessionManagerTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 17.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class SessionManagerTests: XCTestCase {
    // MARK: Tests
    func testValidID() async {
        let sessionsManger: SessionManager = .init()
        
        let id: Int = await sessionsManger.generateNewID()
        let isValid: Bool = await sessionsManger.isValidID(id)

        XCTAssertTrue(isValid)
    }
    
    func testInvalidID() async {
        let sessionsManger: SessionManager = .init()
        
        let id: Int = await sessionsManger.generateNewID()
        _ = await sessionsManger.generateNewID()
        let isValid: Bool = await sessionsManger.isValidID(id)

        XCTAssertFalse(isValid)
    }
}
