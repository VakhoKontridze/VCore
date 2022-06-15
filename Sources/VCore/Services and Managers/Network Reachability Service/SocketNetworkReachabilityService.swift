//
//  SocketConnectionNetworkReachabilityService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 15.06.22.
//

#if !os(watchOS)

import Foundation
import SystemConfiguration

// MARK: - Socket Connection
final class SocketConnectionNetworkReachabilityService {
    // MARK: Properties
    static let shared: SocketConnectionNetworkReachabilityService = .init()
    
    // MARK: Initializers
    private init() {}
    
    // MARK: Connection
    var isConnectedToNetwork: Bool {
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

#endif
