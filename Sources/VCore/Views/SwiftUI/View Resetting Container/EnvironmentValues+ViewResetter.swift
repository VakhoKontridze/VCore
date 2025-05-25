//
//  EnvironmentValues+ViewResetter.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 26.09.23.
//

import SwiftUI

// MARK: - Environment Values + View Resetter
extension EnvironmentValues {
    /// `ViewResetter` of the `View` associated with the environment.
    @Entry public var viewResetter: ViewResetter?
}
