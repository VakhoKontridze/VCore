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
    open var status: NWPath.Status? { .satisfied }
    
    open var isConnectedToNetwork: Bool? { true }
    
    // MARK: Initializers
    /// Initializes `MockNetworkReachabilityService`.
    public init() {}
}

#endif
