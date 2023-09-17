//
//  View.OnTouchInteraction.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 17.09.23.
//

import SwiftUI

// MARK: - View on Touch Interaction
@available(tvOS, unavailable)
extension View {
    /// Adds an action to perform when this `View` recognizes a touch down or touch up interaction.
    ///
    ///     var body: some View {
    ///         Text("Lorem ipsum")
    ///             .onTouchInteraction(perform: { isActive in
    ///                 ...
    ///             })
    ///     }
    ///
    public func onTouchInteraction(
        perform action: @escaping ((Bool) -> Void)
    ) -> some View {
        self
            .modifier(TouchDownTouchUpInteractionRecognizerViewModifier(completion: action))
    }
}

// MARK: - Touch Down & Touch Up Interaction Recognizer View Modifiable
@available(tvOS, unavailable)
private struct TouchDownTouchUpInteractionRecognizerViewModifier: ViewModifier {
    @State private var isDragged: Bool = false

    private let completion: (Bool) -> Void

    init(
        completion: @escaping (Bool) -> Void
    ) {
        self.completion = completion
    }

    func body(content: Content) -> some View {
        content
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ _ in
                        if !isDragged {
                            isDragged = true
                            completion(true)
                        }
                    })
                    .onEnded({ _ in
                        isDragged = false
                        completion(false)
                    })
            )
    }
}
