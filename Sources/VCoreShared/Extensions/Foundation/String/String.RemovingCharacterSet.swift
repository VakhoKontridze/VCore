//
//  String.RemovingCharacterSet.swift
//  VCoreShared
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

import Foundation

// MARK: - String Removing Character Set
extension String {
    package func _removing(_ characterSet: CharacterSet) -> String {
        filter { char in
            guard let unicodeScalar: Unicode.Scalar = char.unicodeScalars.first else { return false }
            return !characterSet.contains(unicodeScalar)
        }
    }
}
