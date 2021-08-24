//
//  NetworkConnectionService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation
import SystemConfiguration

// MARK:- Network Connetion Service
/// Network connection service that manages connection
public struct NetworkConnectionService {
    // MARK: Initializers
    private init() {}
}

// MARK:- Reachability
extension NetworkConnectionService {
    /// Indicates if device is connected to a network
    public static var isConnectedToNetwork: Bool {
        var zeroAddress: sockaddr_in = {
            var zeroAddress: sockaddr_in = .init()
            zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
            zeroAddress.sin_family = sa_family_t(AF_INET)
            return zeroAddress
        }()

        guard
            let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, { address in
                address.withMemoryRebound(to: sockaddr.self, capacity: 1, { address2 in
                    SCNetworkReachabilityCreateWithAddress(nil, address2)
                })
            })
        else {
            return false
        }

        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) { return false }
        
        guard !flags.isEmpty else { return false }

        let isReachable: Bool = flags.contains(.reachable)
        let needsConnection: Bool = flags.contains(.connectionRequired)
        let isConnected: Bool = isReachable && !needsConnection

        return isConnected
    }
}
