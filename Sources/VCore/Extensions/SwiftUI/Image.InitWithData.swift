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
            VCoreFatalError("Could not initialize `UIImage` from the specified data.")
        }
        
        self.init(uiImage: uiImage)

#elseif canImport(AppKit)
        guard
            let nsImage: NSImage = .init(data: data)
        else {
            VCoreFatalError("Could not initialize `NSImage` from the specified data.")
        }
        
        self.init(nsImage: nsImage)

#endif
    }
}
