//
//  Image.SystemImageWithWeight.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 14.04.23.
//

import SwiftUI

// MARK: - Image System Image with Weight
extension Image {
    /// Creates a system symbol image with weight.
    ///
    ///     var body: some View {
    ///         Image(systemName: "shuffle", weight: .bold)!
    ///     }
    ///
    public init?(systemName: String, weight: UIImage.SymbolWeight) {
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
}
