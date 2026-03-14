//
//  Image+InitWithData.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.03.23.
//

import SwiftUI
import OSLog

nonisolated extension Image {
    /// Initializes and returns the `Image` with the specified `Data`.
    ///
    ///     var body: some View {
    ///         Image(data: data)
    ///     }
    ///
    public init(data: Data) {
#if canImport(UIKit)

        if let uiImage: UIImage = .init(data: data) {
            self.init(uiImage: uiImage)
            
        } else {
            Logger.misc.error("Failed to initialize 'UIImage' from 'Data' in 'Image.init(data:)'")
            self.init(uiImage: UIImage())
        }

#elseif canImport(AppKit)

        if let nsImage: NSImage = .init(data: data) {
            self.init(nsImage: nsImage)
            
        } else {
            Logger.misc.error("Failed to initialize 'NSImage' from 'Data' in 'Image.init(data:)'")
            self.init(nsImage: NSImage())
        }

#endif
    }
}
