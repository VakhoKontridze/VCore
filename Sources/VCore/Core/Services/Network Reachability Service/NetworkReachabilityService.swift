//
//  NetworkReachabilityService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 27/5/26.
//

public import Foundation
public import Network

nonisolated public protocol NetworkReachabilityService: AnyObject, Observable, Sendable {
    /// Network connection status.
    var status: NWPath.Status? { get }
    
    /// Indicates if device is connected to a network.
    ///
    /// On app launch, `nil` is returned.
    var isConnectedToNetwork: Bool? { get }
}
