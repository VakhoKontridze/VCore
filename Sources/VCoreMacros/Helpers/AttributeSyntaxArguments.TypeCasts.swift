//
//  AttributeSyntaxArguments.TypeCasts.swift
//  VCoreMacros
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

import Foundation
import SwiftSyntax

// MARK: - Attribute Syntax Arguments Type Casts
extension AttributeSyntax.Arguments {
    func toArgumentListGetAssociatedValue() -> LabeledExprListSyntax? {
        if case .argumentList(let labeledExprListSyntax) = self {
            labeledExprListSyntax
        } else {
            nil
        }
    }
}
