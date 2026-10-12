//
//  Image+SystemImageWithWeight.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 14.04.23.
//

public import SwiftUI

nonisolated extension Image {
#if canImport(UIKit)

    /// Creates a system symbol image with weight.
    ///
    ///     var body: some View {
    ///         Image(systemName: "shuffle", weight: .bold)!
    ///     }
    ///
    public init?(
        systemName: String,
        weight: UIImage.SymbolWeight
    ) {
        guard
            let uiImage: UIImage = .init(
                systemName: systemName,
                withConfiguration: UIImage.SymbolConfiguration(weight: weight)
            )
        else {
            return nil
        }

        self.init(uiImage: uiImage)
    }

    /// Creates a system symbol image with weight.
    ///
    ///     var body: some View {
    ///         Image(systemName: "shuffle", weight: .bold)
    ///     }
    ///
    public init(
        systemNameAndDefault: String,
        weight: UIImage.SymbolWeight
    ) {
        if let image: Image = .init(systemName: systemNameAndDefault, weight: weight) {
            self = image
        } else {
            self = Image(systemName: systemNameAndDefault)
        }
    }

#elseif canImport(AppKit)

    /// Creates a system symbol image with weight.
    ///
    ///     var body: some View {
    ///         Image(systemName: "shuffle", weight: .bold)!
    ///     }
    ///
    public init?(
        systemName: String,
        weight: NSFont.Weight
    ) {
        // `AppKit` has no weight-only configuration, so the system font size stands in.
        // The stroke scales with the symbol, so the weight carries over when the image is resized.
        guard
            let nsImage: NSImage = NSImage(
                systemSymbolName: systemName,
                accessibilityDescription: nil
            )?
            .withSymbolConfiguration(
                NSImage.SymbolConfiguration(
                    pointSize: NSFont.systemFontSize,
                    weight: weight
                )
            )
        else {
            return nil
        }

        self.init(nsImage: nsImage)
    }

    /// Creates a system symbol image with weight.
    ///
    ///     var body: some View {
    ///         Image(systemName: "shuffle", weight: .bold)
    ///     }
    ///
    public init(
        systemNameAndDefault: String,
        weight: NSFont.Weight
    ) {
        if let image: Image = .init(systemName: systemNameAndDefault, weight: weight) {
            self = image
        } else {
            self = Image(systemName: systemNameAndDefault)
        }
    }

#endif
}

#if DEBUG

#Preview {
    VStack(spacing: 10) {
        Image(systemName: "shuffle")
        Image(systemNameAndDefault: "shuffle", weight: .bold)
    }
}

#endif
