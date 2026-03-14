//
//  String+RemovingCharacterSet.swift
//  VCoreShared
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

import Foundation

nonisolated extension String {
    package func _removing(_ characterSet: CharacterSet) -> String {
        filter { char in
            char.unicodeScalars.allSatisfy { unicodeScalar in
                !characterSet.contains(unicodeScalar)
            }
        }
    }
}
