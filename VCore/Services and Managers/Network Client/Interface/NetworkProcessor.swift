//
//  NetworkProcessor.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import Foundation

// MARK: - Network Processor
/// Processor that processes `Error`, `Response,` and `Data`, before they are analyzed and`Data` is decoded.
///
/// For additional docuemntation, refer to `NetworkClient`.
public protocol NetworkProcessor {
    /// Processes`Error`.
    func error(_ error: Error) throws
    
    /// Processes `Response`.
    func response(_ data: Data, _ response: URLResponse) throws -> URLResponse
    
    /// Processes `Data`.
    func data(_ data: Data, _ response: URLResponse) throws -> Data
}

// MARK: - Default Network Processor
struct DefaultNetworkProcessor: NetworkProcessor {
    func error(_ error: Error) throws {}
    
    func response(_ data: Data, _ response: URLResponse) throws -> URLResponse {
        response
    }
    
    func data(_ data: Data, _ response: URLResponse) throws -> Data {
        data
    }
}
