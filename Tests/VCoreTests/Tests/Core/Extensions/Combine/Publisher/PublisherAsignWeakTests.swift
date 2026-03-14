//
//  PublisherAssignWeakTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 21.02.24.
//

import Foundation
import Combine
import XCTest
@testable import VCore

nonisolated final class PublisherAssignWeakTests: XCTestCase {
    // MARK: Tests
    func test() async {
        let model: Model = .init()
        assertInstanceIsDeallocated(model)
    }
    
    // MARK: Types
    nonisolated private final class Model: @unchecked Sendable {
        // MARK: Properties
        private var _value: Int = 0
        var value: Int {
            get { queue.sync { _value } }
            set { queue.sync(flags: .barrier) { _value = newValue } }
        }
        
        private let publisher: PassthroughSubject<Int, Never> = .init()
        
        private let queue: DispatchQueue = .init(
            label: "com.vakhtang-kontridze.vcore.publisher-assign-weak-tests-model",
            attributes: .concurrent
        )
        
        private var cancellables: Set<AnyCancellable> = []

        // MARK: Initializers
        init() {
            addSubscriptions()
        }

        // MARK: Subscriptions
        private func addSubscriptions() {
            publisher
                .assignWeak(to: \.value, on: self)
                .store(in: &cancellables)
        }
    }
}
