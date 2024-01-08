//
//  LabeledExprSyntax.TypeCasts.swift
//  VCoreMacros
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

import Foundation
import SwiftSyntax

// MARK: - Labeled Expr Syntax Type Casts
extension LabeledExprSyntax {
    var toIntegerValue: Int? {
        guard
            let integerLiteral: IntegerLiteralExprSyntax = expression.as(IntegerLiteralExprSyntax.self),
            let value: Int = .init(integerLiteral.literal.text)
        else {
            return nil
        }

        return value
    }

    var toStringValue: String? {
        guard
            let stringLiteral: StringLiteralExprSyntax = expression.as(StringLiteralExprSyntax.self),
            stringLiteral.segments.count == 1,
            let value: String = stringLiteral.segments.first?.stringSegmentAssociatedValue?.content.text
        else {
            return nil
        }

        return value
    }
}
