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
        let service: Service = .init()
        assertInstanceIsDeallocated(service)
    }
    
    // MARK: Types
    private nonisolated final class Service: @unchecked Sendable {
        // MARK: Properties
        private let queue: DispatchQueue = .init(label: "Service")
        
        private var _value: Int = 0
        var value: Int {
            get { queue.sync { _value } }
            set { queue.sync { _value = newValue } }
        }

        private let publisher: PassthroughSubject<Int, Never> = .init()
        
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
