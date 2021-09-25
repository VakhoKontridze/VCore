//
//  NetworkRequestType.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK: - Network Request Type
protocol NetworkRequestType {
    var httpMethod: String { get }
    var httpHeaders: [String: Any] { get }
}

// MARK: - Network GET Request Type
struct NetworkGETRequest: NetworkRequestType {
    let httpMethod: String = "GET"
    
    let httpHeaders: [String: Any] = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
}

// MARK: - Network POST Request Type
struct NetworkPOSTRequest: NetworkRequestType {
    let httpMethod: String = "POST"
    
    let httpHeaders: [String: Any] = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
}
