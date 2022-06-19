//
//  NavigationPath.AppendSequence.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import SwiftUI

// MARK: - Navigation Path Append Sequence
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension NavigationPath {
    /// Adds the elements of a sequence or collection to the end of this path.
    ///
    ///     var path: NavigationPath = .init()
    ///     path.append(contentsOf: ["Destination1", "Destionation2"])
    ///
    mutating public func append(contentsOf newElements: any Sequence<any Hashable>) {
        newElements.forEach({
            append($0)
        })
    }
}
