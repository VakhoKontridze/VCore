//
//  Color.PrimaryInverted.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 24.01.24.
//

import SwiftUI

// MARK: - Color Primary Inverted
extension Color {
    /// `Color` that can be used for inverted primary content.
    ///
    ///     Text("Lorem ipsum")
    ///         .foregroundStyle(Color.primaryInverted)
    ///         .padding()
    ///         .background(content: { Color.primary })
    ///
    public static let primaryInverted: Color = .platformDynamic(Color.white, Color.black)
}

// MARK: - Preview
#if DEBUG

#Preview(body: {
    VStack(content: {
        Text("Lorem ipsum")
            .foregroundStyle(Color.primary)
            .padding()

        Text("Lorem ipsum")
            .foregroundStyle(Color.primaryInverted)
            .padding()
            .background(content: { Color.primary })
    })
})

#endif
