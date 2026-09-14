//
//  NetworkReachabilityService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 27/5/26.
//

public import Combine
public import Foundation
public import Network

nonisolated public protocol NetworkReachabilityService: AnyObject, Observable, Sendable {
    /// Network connection status.
    var status: NWPath.Status? { get }
    
    /// `Publisher` that emits when `status` changes.
    var statusPublisher: AnyPublisher<NWPath.Status?, Never> { get } // TODO: iOS 27.0 - Remove, as it'll be obsoleted by `Observations`
}
