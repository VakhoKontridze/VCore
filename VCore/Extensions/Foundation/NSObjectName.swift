//
//  NSObjectName.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/12/21.
//

import Foundation

// MARK: - NS Object Name
extension NSObject {
    /// `NSObject` class full name.
    public static var nsObjectClassNameFull: String {
        NSStringFromClass(self)
    }
    
    /// `NSObject` class name.
    public static var nsObjectClassName: String? {
        nsObjectClassNameFull.components(separatedBy: ".").last
    }
}
