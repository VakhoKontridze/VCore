//
//  NetworkRequestMethod.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import Foundation

// MARK: - Network Request Method
/// Network service that performs network data tasks.
public protocol NetworkRequestMethod {
    /// HTTP request method.
    var httpMethod: String { get }
}
