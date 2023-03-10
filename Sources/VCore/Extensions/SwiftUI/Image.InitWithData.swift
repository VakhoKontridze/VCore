//
//  Image.InitWithData.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.03.23.
//

import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// MARK: - Image Init with Data
#if canImport(UIKit)

extension Image {
    /// Initializes and returns the `Image` with the specified `Data`.
    ///
    ///     var body: some View {
    ///         Image(data: data)
    ///     }
    ///
    public init(data: Data) {
        guard let uiImage: UIImage = .init(data: data) else { fatalError() }
        self.init(uiImage: uiImage)
    }
}
    
#elseif canImport(AppKit)

extension Image {
    /// Initializes and returns the `Image` with the specified `Data`.
    ///
    ///     var body: some View {
    ///         Image(data: data)
    ///     }
    ///
    public init(data: Data) {
        guard let nsImage: NSImage = .init(data: data) else { fatalError() }
        self.init(nsImage: nsImage)
    }
}

#endif
