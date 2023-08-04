//
//  String.Localized.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.02.23.
//

import Foundation

// MARK: - String Localized
extension String {    
    /// Returns localized `String` from the given table and bundle.
    ///
    ///     "message".localized()
    ///
    public func localized(
        tableName: String? = nil,
        bundle: Bundle = .main,
        value: String = "",
        comment: String = ""
    ) -> String {
        NSLocalizedString(
            self,
            tableName: tableName,
            bundle: bundle,
            value: value,
            comment: comment
        )
    }
}
