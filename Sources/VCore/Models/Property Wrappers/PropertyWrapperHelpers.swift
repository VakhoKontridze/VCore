//
//  PropertyWrapperHelpers.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 22.10.24.
//

import Foundation
import Combine

// MARK: - State
@propertyWrapper
final class PublishedPropertyWrapperState<Value>: @unchecked Sendable {
    // MARK: Properties - Value
    private var _wrappedValue: PublishedPropertyWrapperStorage<Value>
    
    var wrappedValue: PublishedPropertyWrapperStorage<Value> {
        @storageRestrictions(initializes: _wrappedValue)
        init(initialValue) {
            _wrappedValue = initialValue
        }
        get { lock.withLock({ _wrappedValue }) }
        set { lock.withLock({ _wrappedValue = newValue }) }
    }
    
    // MARK: Properties - Lock
    private let lock: NSLock = .init()
    
    // MARK: Initializers
    init(
        wrappedValue: PublishedPropertyWrapperStorage<Value>
    ) {
        self.wrappedValue = wrappedValue
    }
}

// MARK: - Storage
enum PublishedPropertyWrapperStorage<Value> {
    // MARK: Cases
    case value(Value)
    case publisher(PublishedPropertyWrapperPublisher<Value>)
    
    // MARK: Helpers
    var value: Value {
        switch self {
        case .value(let value):
            value
            
        case .publisher(let publisher):
            publisher.subject.value
        }
    }
    
    var projectedValue: PublishedPropertyWrapperPublisher<Value> {
        mutating get {
            switch self {
            case .value(let value):
                let publisher: PublishedPropertyWrapperPublisher = .init(value)
                self = .publisher(publisher)
                return publisher
                
            case .publisher(let publisher):
                return publisher
            }
        }
        set {
            switch self {
            case .value(let value):
                let publisher: PublishedPropertyWrapperPublisher = .init(value)
                self = .publisher(publisher)
                
            case .publisher(let publisher):
                break
            }
        }
    }
    
    mutating func update(_ newValue: Value) {
        switch self {
        case .value:
            self = .publisher(PublishedPropertyWrapperPublisher(newValue))
            
        case .publisher(let publisher):
            publisher.subject.value = newValue
        }
    }
}

// MARK: - Publisher
public struct PublishedPropertyWrapperPublisher<Value>: Publisher {
    // MARK: Properties
    public typealias Output = Value
    public typealias Failure = Never
    
    let subject: CurrentValueSubject<Value, Never>
    
    // MARK: Initializers
    init(_ output: Output) {
        subject = CurrentValueSubject(output)
    }
    
    // MARK: Publisher
    public func receive<S>(
        subscriber: S
    )
        where
            S: Subscriber,
            Never == S.Failure,
            Value == S.Input
    {
        subject.subscribe(subscriber)
    }
}
