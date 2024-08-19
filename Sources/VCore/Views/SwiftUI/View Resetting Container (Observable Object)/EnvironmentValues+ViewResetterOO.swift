//
//  EnvironmentValues+ViewResetterOO.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 23.09.23.
//

import SwiftUI

// MARK: - Environment Values + View Resetter (Observable Object)
extension EnvironmentValues {
    /// `ViewResetterOO` of the `View` associated with the environment.
    ///
    /// Since `ViewResetterOO` is a reference type, `View` updates won't be triggered.
    @EnvironmentValueGeneration public var viewResetterOO: ViewResetterOO?
}
