//
//  View+StableRefreshable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 17/3/26.
//

import SwiftUI

extension View {
    /// Marks this view as refreshable, but prevent `View` redraws cancelling `refreshable` by making it stable.
    ///
    ///     var body: some View {
    ///         ScrollView {
    ///             ...
    ///         }
    ///         .stableRefreshable(action: onRefresh)
    ///     }
    ///
    public func stableRefreshable(
        action: @escaping () async -> Void
    ) -> some View {
        modifier(
            StableRefreshableModifier(
                action: action
            )
        )
    }
}

nonisolated private struct StableRefreshableRefreshToken {
    // MARK: Properties
    let id: UUID
    let continuation: CheckedContinuation<Void, Never>
    
    // MARK: Initializers
    init(
        continuation: CheckedContinuation<Void, Never>
    ) {
        self.id = UUID()
        self.continuation = continuation
    }
}

private struct StableRefreshableModifier: ViewModifier {
    // MARK: Properties
    @State private var token: StableRefreshableRefreshToken?
    
    private let action: () async -> Void
    
    // MARK: Initializers
    init(
        action: @escaping () async -> Void
    ) {
        self.action = action
    }

    // MARK: Body
    func body(content: Content) -> some View {
        content
            .refreshable {
                await withCheckedContinuation {
                    token = StableRefreshableRefreshToken(
                        continuation: $0
                    )
                }
            }
            .task(id: token?.id) {
                guard let token else { return }
                
                await action()
                token.continuation.resume()
                self.token = nil
            }
    }
}
