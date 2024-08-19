//
//  EnvironmentValues+ViewResetter.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 26.09.23.
//

import SwiftUI

// MARK: - Environment Values + View Resetter
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension EnvironmentValues {
    /// `ViewResetter` of the `View` associated with the environment.
    @EnvironmentValueGeneration public var viewResetter: ViewResetter?
}
