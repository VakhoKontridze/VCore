//
//  NWPathStatus+IsConnected.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 14/9/26.
//

import Foundation
public import Network
import OSLog

nonisolated extension NWPath.Status {
    /// Indicates that path is usable and can send and receive data.
    ///
    ///     let isConnected: Bool? = status?.isConnected
    ///
    public var isConnected: Bool {
        switch self {
        case .satisfied: return true
        case .unsatisfied: return false
        case .requiresConnection: return false
        @unknown default:
            Logger.default.fault("Unhandled 'NWPath.Status' '\(String(describing: self))' in 'NWPath.Status.isConnected'")
            return false
        }
    }
}
