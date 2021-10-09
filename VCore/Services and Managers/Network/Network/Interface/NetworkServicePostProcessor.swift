//
//  NetworkServicePostProcessor.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import Foundation

// MARK: - Network Service Post Processor
/// Post-processor app that perofrms additional processing of `Data`,
/// before `JSON` or `Entity` gets decoded by `NetworkService`.
///
/// For additional docuemntation, refer to `NetworkService`.
public protocol NetworkServicePostProcessor {
    /// Perofrms additional processing of `Data` before `JSON` or `Entity` gets decoded.
    func postProcess(
        _ data: Data
    ) -> Result<Data, NetworkError>
}

// MARK: - Default Network Service Post Processor
struct DefaultNetworkServicePostProcessor: NetworkServicePostProcessor {
    func postProcess(
        _ data: Data
    ) -> Result<Data, NetworkError> {
        .success(data)
    }
}
