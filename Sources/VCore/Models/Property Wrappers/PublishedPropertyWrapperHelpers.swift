//
//  PublishedPropertyWrapperHelpers.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 22.10.24.
//

import Foundation
import Combine

@propertyWrapper
final class PublishedPropertyWrapperBox<Value> {
    // MARK: Properties
    var wrappedValue: PublishedPropertyWrapperStorage<Value>
    
    // MARK: Initializers
    init(
        wrappedValue: PublishedPropertyWrapperStorage<Value>
    ) {
        self.wrappedValue = wrappedValue
    }
}

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
    
    // Converts `value` to `publisher`, if needed
    var publisher: PublishedPropertyWrapperPublisher<Value> {
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
    }
    
    mutating func update(_ newValue: Value) {
        publisher.subject.value = newValue
    }
}

/// Publisher for properties in published property wrappers.
public struct PublishedPropertyWrapperPublisher<Value>: Publisher {
    // MARK: Properties
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
    
    // MARK: Types
    public typealias Output = Value
    
    public typealias Failure = Never
}
