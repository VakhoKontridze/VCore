//
//  MockUserDefaults.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import Foundation

// MARK: - User Defaults + Mock
extension UserDefaults {
    nonisolated(unsafe) static let mock: UserDefaults = MockUserDefaults()
}

// MARK: - Mock User Defaults
final class MockUserDefaults: UserDefaults {
    // MARK: Properties
    nonisolated(unsafe) private static var storage: [String: Any] = [:]
    
    private static let queue: DispatchQueue = .init(label: "com.vakhtang-kontridze.vcore.mock-user-defaults", attributes: .concurrent)

    // MARK: Methods
    public override func object(forKey defaultName: String) -> Any? {
        Self.queue.sync(execute: {
            Self.storage[defaultName]
        })
    }

    public override func set(_ value: Any?, forKey defaultName: String) {
        _ = Self.queue.sync(flags: .barrier, execute: {
            if let value {
                Self.storage[defaultName] = value
            } else {
                // `removeObject(forKey:)` shouldn't be called, as it would deadlock
                Self.storage.removeValue(forKey: defaultName)
            }
        })
    }

    public override func removeObject(forKey defaultName: String) {
        _ = Self.queue.sync(flags: .barrier, execute: {
            Self.storage.removeValue(forKey: defaultName)
        })
    }
}
