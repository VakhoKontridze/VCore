//
//  View+OnTouchInteraction.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 17.09.23.
//

import SwiftUI

// MARK: - View + On Touch Interaction
@available(tvOS, unavailable)
extension View {
    /// Adds an action to perform when `View` recognizes a touch down or touch up interaction.
    ///
    ///     var body: some View {
    ///         Text("Lorem ipsum")
    ///             .onTouchInteraction(minimumDistance: 0, perform: { isActive in
    ///                 ...
    ///             })
    ///     }
    ///
    public func onTouchInteraction(
        minimumDistance: CGFloat = 10,
        perform action: @escaping ((Bool) -> Void)
    ) -> some View {
        self
            .modifier(
                TouchDownTouchUpInteractionRecognizerViewModifier(
                    minimumDistance: minimumDistance,
                    completion: action
                )
            )
    }
}

// MARK: - Touch Down & Touch Up Interaction Recognizer View Modifiable
@available(tvOS, unavailable)
private struct TouchDownTouchUpInteractionRecognizerViewModifier: ViewModifier {
    // MARK: Properties
    private let minimumDistance: CGFloat
    private let completion: (Bool) -> Void

    @State private var isDragged: Bool = false

    // MARK: Initializers
    init(
        minimumDistance: CGFloat,
        completion: @escaping (Bool) -> Void
    ) {
        self.minimumDistance = minimumDistance
        self.completion = completion
    }

    // MARK: Body
    func body(content: Content) -> some View {
        content
            .gesture(
                DragGesture(minimumDistance: minimumDistance)
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

// MARK: - Preview
#if DEBUG

#if !os(tvOS)

#Preview(body: {
    @Previewable @State var isPressed: Bool = false

    Text(isPressed ? "Recognized" : "Standby")
        .onTouchInteraction(minimumDistance: 0, perform: { isPressed = $0 })
})

#endif

#endif
