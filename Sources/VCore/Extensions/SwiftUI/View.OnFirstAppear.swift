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
