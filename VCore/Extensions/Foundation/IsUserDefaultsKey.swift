//
//  IsUserDefaultsKey.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/12/21.
//

import Foundation

// MARK:- Is User Defaults Key
extension String {
    /// Checks if value of this key is stored in `UserDefaults`
    public func isUserDefaultsKey(in defaults: UserDefaults = .standard) -> Bool {
        defaults.value(forKey: self) != nil
    }
}
