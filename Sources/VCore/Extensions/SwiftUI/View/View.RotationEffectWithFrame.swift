//
//  View.RotationEffectWithFrame.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28.11.23.
//

import SwiftUI

// MARK: - View Rotation Effect with Frame
extension View {
    /// Rotates `View`'s rendered output around the specified point, while adjusting the frame.
    ///
    ///     HStack(spacing: 0, content: {
    ///         Text("Lorem")
    ///             .border(.red)
    ///
    ///         Text("Lorem ipsum dolor")
    ///             .fixedSize()
    ///             .border(.blue)
    ///             .rotationEffectWithFrame(.degrees(-45))
    ///             .border(.green)
    ///     })
    ///     .border(.green)
    ///
    public func rotationEffectWithFrame(_ angle: Angle) -> some View {
        modifier(RotationEffectWithFrameViewModifier(angle: angle))
    }
}

// MARK: - Rotation Effect with Frame View Modifier
private struct RotationEffectWithFrameViewModifier: ViewModifier {
    // MARK: Properties
    private let angle: Angle

    @State private var size: CGSize = .zero
    private var bounds: CGRect {
        CGRect(origin: CGPoint.zero, size: size)
            .offsetBy(
                dx: -size.width / 2,
                dy: -size.height / 2
            )
            .applying(CGAffineTransform(rotationAngle: CGFloat(angle.radians)))
    }

    // MARK: Initializers
    init(angle: Angle) {
        self.angle = angle
    }

    // MARK: Body
    func body(content: Content) -> some View {
        content
            .rotationEffect(angle)
            .background(content: {
                GeometryReader(content: { proxy in
                    Color.clear
                        .task(id: proxy.frame(in: .local), {
                            size = proxy.size
                        })
                })
                .allowsHitTesting(false) // Avoids blocking gestures
            })
            .frame(size: bounds.size)
    }
}

// MARK: - Preview
#if DEBUG

#Preview(body: {
    HStack(spacing: 0, content: {
        Text("Lorem")
            .border(.red)

        Text("Lorem ipsum dolor")
            .fixedSize()
            .border(.blue)
            .rotationEffectWithFrame(.degrees(-45))
            .border(.green)
    })
    .border(.green)
})

#endif
