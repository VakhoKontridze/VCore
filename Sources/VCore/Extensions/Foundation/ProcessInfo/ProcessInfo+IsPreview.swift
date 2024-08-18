//
//  ProcessInfo+IsPreview.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28.11.23.
//

import Foundation

// MARK: - Process Info + Is Preview
extension ProcessInfo {
    /// Indicates if process is running for previews.
    ///
    ///     let isPreview: Bool = ProcessInfo.processInfo.isPreview
    ///
    public var isPreview: Bool {
        environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
