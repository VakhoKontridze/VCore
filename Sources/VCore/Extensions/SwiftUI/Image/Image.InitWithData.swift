//
//  Image.InitWithData.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.03.23.
//

import SwiftUI
import OSLog

// MARK: - Image Init with Data
extension Image {
    /// Initializes and returns the `Image` with the specified `Data`.
    ///
    ///     var body: some View {
    ///         Image(data: data)
    ///     }
    ///
    public init(data: Data) {
#if canImport(UIKit)
        guard
            let uiImage: UIImage = .init(data: data)
        else {
            Logger.misc.critical("Failed to initialize 'UIImage' from `Data`")
            fatalError()
        }
        
        self.init(uiImage: uiImage)
#elseif canImport(AppKit)
        guard
            let nsImage: NSImage = .init(data: data)
        else {
            Logger.misc.critical("Failed to initialize 'NSImage' from `Data`")
            fatalError()
        }
        
        self.init(nsImage: nsImage)
#endif
    }
}
