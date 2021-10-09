//
//  Deprecations.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import Foundation

// MARK: - Session Manager
@available(*, deprecated, renamed: "SessionManager")
public typealias NetworkSessionManager = SessionManager

// MARK: - Network Service
extension NetworkService {
    @available(*, deprecated, renamed: "default")
    public static var shared: NetworkService { .default }
}
