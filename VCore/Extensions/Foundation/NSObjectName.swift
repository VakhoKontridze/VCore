//
//  NSObjectName.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/12/21.
//

import Foundation

// MARK: - NS Object Name
extension NSObject {
    /// `NSObject` class name.
    public static var nsObjectName: String? {
        NSStringFromClass(self)
            .components(separatedBy: ".")
            .last
    }
}
