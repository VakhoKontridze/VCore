//
//  ViewResetterEnvironmentValue.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 23.09.23.
//

import SwiftUI

// MARK: - View Resetter Environment Value
extension EnvironmentValues {
    /// `NavigationStackCoordinatorEnvironmentKey` of the `View` associated with the environment.
    ///
    /// Since `ViewResetter` is a reference type, `View` updates won't be triggered.
    ///
    ///     @Environment(\.viewResetter) private var viewResetter: ViewResetter!
    ///
    ///     var body: some View {
    ///         ...
    ///     }
    ///
    public var viewResetter: ViewResetter? {
        get { self[ViewResetterEnvironmentKey.self] }
        set { self[ViewResetterEnvironmentKey.self] = newValue }
    }
}

// MARK: - View Resetter Environment Key
private struct ViewResetterEnvironmentKey: EnvironmentKey {
    static var defaultValue: ViewResetter? = nil
}
