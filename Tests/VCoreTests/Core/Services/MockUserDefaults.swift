//
//  MockUserDefaults.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import Foundation

nonisolated extension UserDefaults {
    nonisolated(unsafe) static let mock: UserDefaults = MockUserDefaults()
}

nonisolated final class MockUserDefaults: UserDefaults {
    // MARK: Properties
    private var storage: [String: Any] = [:]

    private let queue: DispatchQueue = .init(
        label: "com.vakhtang-kontridze.vcore.mock-user-defaults",
        attributes: .concurrent
    )

    // MARK: Methods
    override public func object(forKey defaultName: String) -> Any? {
        queue.sync {
            storage[defaultName]
        }
    }

    override public func set(_ value: Any?, forKey defaultName: String) {
        _ = queue.sync(flags: .barrier) {
            if let value {
                storage[defaultName] = value
            } else {
                // `removeObject(forKey:)` shouldn't be called, as it would deadlock
                storage.removeValue(forKey: defaultName)
            }
        }
    }

    override public func removeObject(forKey defaultName: String) {
        _ = queue.sync(flags: .barrier) {
            storage.removeValue(forKey: defaultName)
        }
    }
}
