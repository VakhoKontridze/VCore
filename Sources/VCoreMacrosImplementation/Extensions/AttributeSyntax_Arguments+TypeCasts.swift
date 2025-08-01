//
//  AttributeSyntax_Arguments+TypeCasts.swift
//  VCoreMacrosImplementation
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

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
