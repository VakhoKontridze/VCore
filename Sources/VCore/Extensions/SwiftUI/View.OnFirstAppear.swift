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
    ///     content
    ///         .onFirstAppear(perform: fetchData)
    ///
    public func onFirstAppear(
        perform action: (() -> Void)? = nil
    ) -> some View {
        self
            .modifier(FirstAppearViewModifier(action: action))
    }
}

// MARK: - First Appear View Modifier
private struct FirstAppearViewModifier: ViewModifier {
    // MARK: Properties
    @State private var didLoad: Bool = false
    private let action: (() -> Void)?
    
    // MARK: Initializers
    init(action: (() -> Void)?) {
        self.action = action
    }

    // MARK: Body
    func body(content: Content) -> some View {
        content
            .onAppear(perform: {
                guard !didLoad else { return }
                didLoad = true
                
                action?()
            })
    }
}
