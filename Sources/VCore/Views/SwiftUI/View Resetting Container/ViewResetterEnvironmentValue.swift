//
//  ViewResetterEnvironmentValue.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 26.09.23.
//

import SwiftUI

// MARK: - View Resetter Extension
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension View {
    func viewResetter(
        _ viewResetter: ViewResetter
    ) -> some View {
        self
            .environment(\.viewResetter, viewResetter)
    }
}

// MARK: - View Resetter Environment Value
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension EnvironmentValues {
    /// `ViewResetter` of the `View` associated with the environment.
    public var viewResetter: ViewResetter? {
        get { self[ViewResetterEnvironmentKey.self] }
        set { self[ViewResetterEnvironmentKey.self] = newValue }
    }
}

// MARK: - View Resetter Environment Key
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
private struct ViewResetterEnvironmentKey: EnvironmentKey {
    static let defaultValue: ViewResetter? = nil
}
