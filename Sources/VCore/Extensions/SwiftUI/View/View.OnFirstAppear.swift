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
    ///     @State private var didAppearForTheFirstTime: Bool = false
    ///
    ///     var body: some View {
    ///         content
    ///             .onFirstAppear($didAppearForTheFirstTime, perform: { ... })
    ///     }
    ///
    public func onFirstAppear(
        _ didAppearForTheFirstTime: Binding<Bool>,
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
