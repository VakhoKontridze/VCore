//
//  ViewResetterEnvironmentValue.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 23.09.23.
//

import SwiftUI

// MARK: - View Resetter Extension (Observable Object)
extension View {
    func viewResetterOO(
        _ viewResetter: ViewResetterOO
    ) -> some View {
        self
            .environment(\.viewResetterOO, viewResetter)
    }
}

// MARK: - View Resetter Environment Value (Observable Object)
extension EnvironmentValues {
    /// `ViewResetterOO` of the `View` associated with the environment.
    ///
    /// Since `ViewResetterOO` is a reference type, `View` updates won't be triggered.
    public var viewResetterOO: ViewResetterOO? {
        get { self[ViewResetterEnvironmentKeyOO.self] }
        set { self[ViewResetterEnvironmentKeyOO.self] = newValue }
    }
}

// MARK: - View Resetter Environment Key (Observable Object)
private struct ViewResetterEnvironmentKeyOO: EnvironmentKey {
    static var defaultValue: ViewResetterOO? = nil
}
