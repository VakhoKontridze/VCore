//
//  AttributeSyntax_Arguments+TypeCasts.swift
//  VCoreMacrosImplementation
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

#if !(os(iOS) || os(tvOS) || os(watchOS) || os(visionOS))

import Foundation
import SwiftSyntax

extension AttributeSyntax.Arguments {
    func toArgumentListGetAssociatedValue() -> LabeledExprListSyntax? {
        if case .argumentList(let labeledExprListSyntax) = self {
            labeledExprListSyntax
        } else {
            nil
        }
    }
}

#endif
