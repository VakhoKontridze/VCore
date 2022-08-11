//
//  View.OnFirstAppear.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import SwiftUI

// MARK: - View on First Appear
extension View {
    /// Adds an action to perform before this `View` appears for the first time.
    ///
    ///     @MainActor final class Presenter: ObservableObject, SwiftUIFirstAppearLifecycleManager {
    ///         @Published var didAppearForTheFirstTime: Bool = false
    ///
    ///         func didLoad() {
    ///             ...
    ///         }
    ///     }
    ///
    ///     @StateObject var presenter: Presenter = .init()
    ///
    ///     var body: some View {
    ///         content
    ///             .onFirstAppear(didAppear: $presenter.didAppearForTheFirstTime, perform: { presenter.didLoad() })
    ///     }
    ///
    public func onFirstAppear(
        didAppear didAppearForTheFirstTime: Binding<Bool>,
        perform action: (() -> Void)? = nil
    ) -> some View {
        self
            .onAppear(perform: {
                guard !didAppearForTheFirstTime.wrappedValue else { return }
                
                didAppearForTheFirstTime.wrappedValue = true
                action?()
            })
    }
}

// MARK: - SwiftUI First Appear Lifecycle Manager
/// Protocol that manages state of `View`'s first appear.
///
/// In `MVP`, `VIP`, and `VIPER` architectures, this protocol is conformed to by a `Presenter`.
/// in `MVVM` architecture, this protocol is conformed to by a `ViewModel.`
@MainActor public protocol SwiftUIFirstAppearLifecycleManager: ObservableObject {
    /// Indicates if `View` has already appeared for the first time.
    /*@Published*/ var didAppearForTheFirstTime: Bool { get set }
}
