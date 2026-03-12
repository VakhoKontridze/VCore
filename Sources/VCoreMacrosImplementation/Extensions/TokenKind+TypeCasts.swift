//
//  TokenKind+TypeCasts.swift
//  VCoreMacrosImplementation
//
//  Created by Vakhtang Kontridze on 19.04.24.
//

#if !(os(iOS) || os(tvOS) || os(watchOS) || os(visionOS))

import Foundation
import SwiftSyntax

extension TokenKind {
    func toKeywordAssociatedValue() -> Keyword? {
        if case .keyword(let keyword) = self {
            keyword
        } else {
            nil
        }
    }
}

#endif
