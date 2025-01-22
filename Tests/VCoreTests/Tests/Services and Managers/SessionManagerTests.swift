//
//  SessionManagerTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 17.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct SessionManagerTests {
    @Test
    func testValidID() async {
        let sessionsManger: SessionManager = .init()
        
        let id: Int = await sessionsManger.generateNewID()
        let isValid: Bool = await sessionsManger.isValidID(id)

        #expect(isValid)
    }
    
    @Test
    func testInvalidID() async {
        let sessionsManger: SessionManager = .init()
        
        let id: Int = await sessionsManger.generateNewID()
        _ = await sessionsManger.generateNewID()
        let isValid: Bool = await sessionsManger.isValidID(id)

        #expect(!isValid)
    }
}
