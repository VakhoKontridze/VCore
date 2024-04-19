//
//  TokenTypeCasts.swift
//  VCoreMacros
//
//  Created by Vakhtang Kontridze on 19.04.24.
//

import Foundation
import SwiftSyntax

// MARK: - Token Type Casts
extension TokenKind {
    func toKeywordAssociatedValue() -> Keyword? {
        if case .keyword(let keyword) = self {
            keyword
        } else {
            nil
        }
    }
}
