//
//  NetworkReachabilityService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 27/5/26.
//

#if DEBUG

import Foundation
public import Network

nonisolated open class MockNetworkReachabilityService: NetworkReachabilityService, @unchecked Sendable {
    // MARK: Properties - Status
    /// Network connection status.
    open var status: NWPath.Status? { .satisfied }
    
    /// Indicates if device is connected to a network.
    ///
    /// On app launch, `nil` is returned.
    open var isConnectedToNetwork: Bool? { true }
    
    // MARK: Initializers
    /// Initializes `MockNetworkReachabilityService`.
    public init() {}
}

#endif
