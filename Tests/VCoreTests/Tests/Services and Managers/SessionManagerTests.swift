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
        
        let id: Int = await sessionsManger.newSessionID
        let result: Bool = await sessionsManger.sessionIsValid(id: id)
        
        XCTAssertTrue(result)
    }
    
    func testInvalidID() async {
        let sessionsManger: SessionManager = .init()
        
        let id: Int = await sessionsManger.newSessionID
        _ = await sessionsManger.newSessionID
        let result: Bool = await sessionsManger.sessionIsValid(id: id)
        
        XCTAssertTrue(result)
    }
}
