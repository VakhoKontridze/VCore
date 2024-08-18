//
//  NavigationPath+Methods.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import SwiftUI

// MARK: - Navigation Path + Methods
extension NavigationPath {
    /// Adds the elements of a sequence or collection to the end of the path.
    ///
    ///     var path: NavigationPath = .init()
    ///     path.append(contentsOf: ["Destination1", "Destination2"])
    ///
    mutating public func append(
        contentsOf newElements: some Sequence<some Hashable>
    ) {
        newElements.forEach { append($0) }
    }
    
    /// Removes all elements from the path.
    ///
    /// Can be used to pop too root.
    ///
    ///     var path: NavigationPath = .init(...)
    ///     path.removeAll()
    ///
    mutating public func removeAll() {
        removeLast(count)
    }
}
