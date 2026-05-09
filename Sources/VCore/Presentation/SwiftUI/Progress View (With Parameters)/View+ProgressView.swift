//
//  View+ProgressView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.10.22.
//

import SwiftUI

extension View {
    /// Presents `ProgressView` when `parameters` is non-`nil`.
    ///
    ///     @State private var parameters: ProgressViewParameters = .init()
    ///
    ///     var body: some View {
    ///         content
    ///             .progressView(parameters: parameters)
    ///     }
    ///
    public func progressView(
        parameters: ProgressViewParameters?
    ) -> some View {
        self
            .modifier(
                ProgressViewModifier(
                    parameters: parameters
                )
            )
    }
}

private struct ProgressViewModifier: ViewModifier {
    // MARK: Properties - Parameters
    private let parameters: ProgressViewParameters?
    
    @State private var isVisible: Bool = false
    
    // MARK: Subscriptions
    @State private var visibilityTask: Task<Void, Never>?
    
    // MARK: Initializers
    init(
        parameters: ProgressViewParameters?
    ) {
        self.parameters = parameters
    }
    
    // MARK: Body
    func body(content: Content) -> some View {
        content
            .blocksHitTesting(parameters?.isInteractionEnabled == false)
            .overlay {
                if
                    let parameters,
                    isVisible
                {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(parameters.scalingFactor ?? 1)
                        .tint(parameters.color)
                }
            }
        
            .onChange(of: parameters.visibilityData, initial: true) { (_, newValue) in
                visibilityTask?.cancel()
                visibilityTask = nil
                
                if newValue.isVisible {
                    if let delay: Duration = newValue.delay {
                        visibilityTask = Task {
                            defer { visibilityTask = nil }
                            
                            do {
                                try await Task.sleep(for: delay)
                            } catch {
                                return
                            }
                            
                            isVisible = true
                        }
                        
                    } else {
                        isVisible = true
                    }
                    
                } else {
                    isVisible = false
                }
            }
            .onDisappear {
                visibilityTask?.cancel()
                visibilityTask = nil
            }
    }
}

// Needed, as `ProgressViewParameters` cannot be equatable
nonisolated private struct VisibilityData: Equatable {
    let isVisible: Bool
    let delay: Duration?
}

nonisolated extension Optional where Wrapped == ProgressViewParameters {
    fileprivate var visibilityData: VisibilityData {
        .init(
            isVisible: self != nil,
            delay: self?.appearanceDelay
        )
    }
}

#if DEBUG

#Preview {
    let parameters: ProgressViewParameters = .init()

    Color.clear
        .progressView(parameters: parameters)
}

#endif
